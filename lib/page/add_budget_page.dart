import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/bloc/budget/add_budget/add_budget_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_bloc.dart';
import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:intl/intl.dart';

class AddBudgetPage extends StatefulWidget {
  static const routeName = '/add_budget_page';
  @override
  _AddBudgetPageState createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusScopeNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Budget"),
        ),
        body: BlocConsumer<AddBudgetBloc, AddBudgetState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              _showSnackBar(context, formStatus.exception.toString());
            } else if (formStatus is SubmissionSuccess) {
              Navigator.of(context).pushReplacementNamed(HomePage.routeName);
            }
          },
          builder: (context, state) {
            return state.formStatus is FormLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _addBudgetForm(context),
                    ],
                  );
          },
        ));
  }

  Widget _addBudgetForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: FocusScope(
          node: _focusScopeNode,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _nameField(),
                  _priceField(),
                  _detailField(),
                  _categoriesField(),
                  _budgetTypeField(),
                  _isMonthlyField(),
                  _startDateField(),
                  _finishDateField(),
                  SizedBox(height: 20),
                  _addButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Name',
        ),
        validator: (value) => state.isValidName ? null : "İsim çok kısa.",
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) => context.read<AddBudgetBloc>().add(
              AddBudgetNameChanged(name: value),
            ),
      );
    });
  }

  Widget _priceField() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Price',
        ),
        validator: (value) => state.isValidPrice ? null : "Hatalı giriş",
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) {
          context.read<AddBudgetBloc>().add(
                AddBudgetPriceChanged(price: value),
              );
        },
      );
    });
  }

  Widget _detailField() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return TextFormField(
        maxLines: 2,
        decoration: InputDecoration(
          hintText: 'Detail',
        ),
        validator: (value) => state.isValidDetail ? null : "Metin çok kısa.",
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) => context.read<AddBudgetBloc>().add(
              AddBudgetDetailChanged(detail: value),
            ),
      );
    });
  }

  Widget _budgetTypeField() {
    bool? selectedType;
    var budgetTypes = [
      DropdownMenuItem(child: Text('Gider'), value: false),
      DropdownMenuItem(child: Text('Gelir'), value: true)
    ];
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return DropdownButtonFormField<bool>(
          hint: Text("Budget Type"),
          items: budgetTypes,
          value: selectedType,
          onTap: _focusScopeNode.unfocus,
          validator: (value) =>
              state.isValidBudgetType ? null : "Bütçe tipi seçiniz.",
          onChanged: (value) {
            selectedType = value;
            context.read<AddBudgetBloc>().add(
                  AddBudgetBudgetTypeChanged(budgetType: value!),
                );
          });
    });
  }

  Widget _isMonthlyField() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Aylık Tekrar',
            style: TextStyle(fontSize: 14),
          ),
          value: state.isMonthly,
          onChanged: (value) {
            _focusScopeNode.unfocus();
            context.read<AddBudgetBloc>().add(
                  AddBudgetIsMonthlyChanged(isMonthly: value!),
                );
          });
    });
  }

  Widget _categoriesField() {
    Category? selectedCategory;
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return DropdownButtonFormField<Category>(
          hint: Text("Category"),
          items: _createCategories(state.categories),
          value: selectedCategory,
          onTap: () => _focusScopeNode.unfocus(),
          validator: (value) =>
              state.isValidCategory ? null : "Kategori seçiniz.",
          onChanged: (value) {
            selectedCategory = value;
            context.read<AddBudgetBloc>().add(
                  AddBudgetCategoryChanged(categoryId: value!.id),
                );
          });
    });
  }

  Widget _startDateField() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Text('Başlangıç'),
        title: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () async {
                _focusScopeNode.unfocus();
                var date = await _pickDate(context);
                if (date != null) {
                  context.read<AddBudgetBloc>().add(
                        AddBudgetStartDateChanged(startDate: date),
                      );
                }
              },
              child: Text(DateFormat('d.MM.y').format(state.startDate))),
        ),
      );
    });
  }

  Widget _finishDateField() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return state.isMonthly
          ? ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Text('Bitiş'),
              title: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    _focusScopeNode.unfocus();
                    var date = await _pickDate(context,
                        firstDate:
                            DateUtils.addMonthsToMonthDate(state.startDate, 1)
                                .add(Duration(days: state.startDate.day - 1)));
                    if (date != null) {
                      context.read<AddBudgetBloc>().add(
                            AddBudgetFinishDateChanged(finishDate: date),
                          );
                    }
                  },
                  child: Text(DateFormat('d.MM.y').format(state.finishDate ??
                      DateUtils.addMonthsToMonthDate(DateTime.now(), 1)
                          .add(Duration(days: DateTime.now().day - 1)))),
                ),
              ),
            )
          : Container();
    });
  }

  Widget _addButton() {
    return BlocBuilder<AddBudgetBloc, AddBudgetState>(
        builder: (context, state) {
      return Container(
        child: state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AddBudgetBloc>().add(AddBudgetSubmitted());
                    context
                        .read<BudgetBloc>()
                        .add(GetBudgets(selectedDate: DateTime.now()));
                  }
                },
                child: Text('Ekle'),
              ),
      );
    });
  }

  List<DropdownMenuItem<Category>> _createCategories(
      List<Category> categories) {
    List<DropdownMenuItem<Category>> categoryItems = [];
    categories.forEach((category) {
      categoryItems.add(
        DropdownMenuItem(
          child: Text(category.name),
          value: category,
        ),
      );
    });
    return categoryItems;
  }

  Future<DateTime?> _pickDate(BuildContext context,
      {DateTime? firstDate, DateTime? lastDate}) async {
    final addBudgetState = context.read<AddBudgetBloc>().state;
    final initialDate = addBudgetState.startDate;
    final newDate = await showDatePicker(
      context: context,
      initialDate: firstDate ?? initialDate,
      firstDate: firstDate ?? DateTime(DateTime.now().year - 5),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 5),
    );
    return Future.value(newDate);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
