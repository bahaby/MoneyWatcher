import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/bloc/app/app_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_form/budget_form_bloc.dart';
import 'package:money_watcher/bloc/form_submission_status.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/page/home_page.dart';
import 'package:intl/intl.dart';

class AddUpdateBudgetPage extends StatefulWidget {
  static const routeName = '/add_budget_page';
  @override
  _AddUpdateBudgetPageState createState() => _AddUpdateBudgetPageState();
}

class _AddUpdateBudgetPageState extends State<AddUpdateBudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final _focusScopeNode = FocusScopeNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Budget"),
        ),
        body: BlocConsumer<BudgetFormBloc, BudgetFormState>(
          listener: (context, state) {
            final formStatus = state.formStatus;
            if (formStatus is SubmissionFailed) {
              _showSnackBar(context, formStatus.exception.toString());
            }
          },
          builder: (context, state) {
            return state is BudgetFormLoading
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
                  _submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
        builder: (context, state) {
      return TextFormField(
        decoration: InputDecoration(
          hintText: 'Name',
        ),
        validator: (value) => state.isValidName ? null : "İsim çok kısa.",
        initialValue: (state.isUpdate) ? state.name : null,
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) => context.read<BudgetFormBloc>().add(
              BudgetFormNameChanged(name: value),
            ),
      );
    });
  }

  Widget _priceField() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
        builder: (context, state) {
      return TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Price',
        ),
        initialValue: (state.isUpdate) ? state.price.toString() : null,
        validator: (value) => state.isValidPrice ? null : "Hatalı giriş",
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) {
          context.read<BudgetFormBloc>().add(
                BudgetFormPriceChanged(price: value),
              );
        },
      );
    });
  }

  Widget _detailField() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
        builder: (context, state) {
      return TextFormField(
        maxLines: 2,
        decoration: InputDecoration(
          hintText: 'Detail',
        ),
        initialValue: (state.isUpdate) ? state.detail : null,
        validator: (value) => state.isValidDetail ? null : "Metin çok kısa.",
        onEditingComplete: _focusScopeNode.nextFocus,
        onChanged: (value) => context.read<BudgetFormBloc>().add(
              BudgetFormDetailChanged(detail: value),
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
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
        builder: (context, state) {
      selectedType = (state.isUpdate) ? state.budgetType : null;
      return DropdownButtonFormField<bool>(
          hint: Text("Budget Type"),
          items: budgetTypes,
          value: selectedType,
          onTap: _focusScopeNode.unfocus,
          validator: (value) =>
              state.isValidBudgetType ? null : "Bütçe tipi seçiniz.",
          onChanged: (value) {
            selectedType = value;
            context.read<BudgetFormBloc>().add(
                  BudgetFormBudgetTypeChanged(budgetType: value!),
                );
          });
    });
  }

  Widget _isMonthlyField() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
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
            context.read<BudgetFormBloc>().add(
                  BudgetFormIsMonthlyChanged(isMonthly: value!),
                );
          });
    });
  }

  Widget _categoriesField() {
    Category? selectedCategory;
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
        builder: (context, state) {
      selectedCategory =
          state.isUpdate ? _idToCategory(state.categoryId!) : null;
      return DropdownButtonFormField<Category>(
          hint: Text("Category"),
          items: _createCategories(context),
          value: selectedCategory,
          onTap: () => _focusScopeNode.unfocus(),
          validator: (value) =>
              state.isValidCategory ? null : "Kategori seçiniz.",
          onChanged: (value) {
            selectedCategory = value;
            context.read<BudgetFormBloc>().add(
                  BudgetFormCategoryChanged(categoryId: value!.id),
                );
          });
    });
  }

  Widget _startDateField() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
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
                  context.read<BudgetFormBloc>().add(
                        BudgetFormStartDateChanged(startDate: date),
                      );
                }
              },
              child: Text(DateFormat('d.MM.y').format(state.startDate))),
        ),
      );
    });
  }

  Widget _finishDateField() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
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
                      context.read<BudgetFormBloc>().add(
                            BudgetFormFinishDateChanged(finishDate: date),
                          );
                    }
                  },
                  child: Text(DateFormat('d.MM.y').format(state.finishDate)),
                ),
              ),
            )
          : Container();
    });
  }

  Widget _submitButton() {
    return BlocBuilder<BudgetFormBloc, BudgetFormState>(
        builder: (context, state) {
      return Container(
        child: state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<BudgetFormBloc>().add(BudgetFormSubmitted());
                  }
                },
                child: Text('Ekle'),
              ),
      );
    });
  }

  Category _idToCategory(int categoryId) {
    var categories = (context.read<AppBloc>().state as AppLoaded).categories;
    return categories.firstWhere((category) => category.id == categoryId);
  }

  List<DropdownMenuItem<Category>> _createCategories(BuildContext context) {
    var categories = (context.read<AppBloc>().state as AppLoaded).categories;
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
    final initialDate = context.read<BudgetFormBloc>().state.startDate;
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
