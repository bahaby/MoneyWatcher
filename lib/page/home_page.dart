import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_watcher/bloc/app/app_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_detail/budget_detail_bloc.dart';
import 'package:money_watcher/bloc/budget/budget_form/budget_form_bloc.dart';
import 'package:money_watcher/model/category.dart';
import 'package:money_watcher/page/add_update_budget_page.dart';
import 'package:money_watcher/page/loading_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/view_model/daily_budget_view_model.dart';
import 'package:money_watcher/view_model/weekly_budget_view_model.dart';
import 'package:money_watcher/widget/daily_budgets/budget_day_overall_widget.dart';
import 'package:money_watcher/widget/weekly_budgets/budget_week_overall_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  List<Category> categories = [];
  int _selectedTapIndex = 0;
  TabController? _tabController;
  final storageService = getIt<LocalStorageService>();
  @override
  void initState() {
    super.initState();
    context.read<BudgetBloc>().add(GetBudgets(selectedDate: _selectedDate));
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        _selectedTapIndex = _tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(builder: (context, state) {
      if (state is AppLoaded) {
        categories = state.categories;
        return BlocBuilder<BudgetBloc, BudgetState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  (_selectedTapIndex == 2)
                      ? _yearChanger(context)
                      : _monthChanger(context)
                ],
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Text("Günlük"),
                    Text("Haftalık"),
                    Text("Aylık"),
                  ],
                ),
              ),
              body: (state is BudgetLoaded)
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                            child: BudgetDayOverallWidget(
                          model: DailyBudgetViewModel.fromBudgets(
                              budgetsToMap: state.selectedMonthBudgets,
                              categories: categories),
                        )),
                        Center(
                            child: BudgetWeekOverallWidget(
                          model: WeeklyBudgetViewModel.fromBudgets(
                              budgetsToMap: state.selectedMonthBudgets,
                              selectedDate: _selectedDate),
                        )),
                        Center(child: Text("Aylık")),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  Navigator.of(context)
                      .pushNamed(AddUpdateBudgetPage.routeName);
                },
              ),
            );
          },
        );
      } else {
        return LoadingPage();
      }
    });
  }

  Widget _monthChanger(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                _selectedDate = DateTime(_selectedDate.year,
                    _selectedDate.month - 1, _selectedDate.day);
                context
                    .read<BudgetBloc>()
                    .add(GetBudgets(selectedDate: _selectedDate));
              }),
          Text(DateFormat('MM.y').format(_selectedDate)),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                _selectedDate = DateTime(_selectedDate.year,
                    _selectedDate.month + 1, _selectedDate.day);
                context
                    .read<BudgetBloc>()
                    .add(GetBudgets(selectedDate: _selectedDate));
              })
        ],
      ),
    );
  }

  Widget _yearChanger(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                _selectedDate = DateTime(_selectedDate.year - 1,
                    _selectedDate.month, _selectedDate.day);
                context
                    .read<BudgetBloc>()
                    .add(GetBudgets(selectedDate: _selectedDate));
              }),
          Text(DateFormat('y').format(_selectedDate)),
          IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                _selectedDate = DateTime(_selectedDate.year + 1,
                    _selectedDate.month, _selectedDate.day);
                context
                    .read<BudgetBloc>()
                    .add(GetBudgets(selectedDate: _selectedDate));
              })
        ],
      ),
    );
  }
}
