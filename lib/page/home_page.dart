import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_watcher/bloc/budget/budget_bloc.dart';
import 'package:money_watcher/page/add_budget_page.dart';
import 'package:money_watcher/service/budget_service.dart';
import 'package:money_watcher/service/local_storage_service.dart';
import 'package:money_watcher/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_watcher/view_model/daily_budget_view_model.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  int _selectedTapIndex = 0;
  TabController? _tabController;
  final storageService = getIt<LocalStorageService>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        _selectedTapIndex = _tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          body: Stack(
            children: [
              Text("Test"),
              (state is BudgetLoaded)
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        Center(
                            child: Text(DailyBudgetViewModel.fromBudgets(
                                    state.selectedMonthBudgets)
                                .daysBudgetsItems
                                .first
                                .dayBudgetItems
                                .last
                                .name
                                .toString())),
                        Center(child: Text("Haftalık")),
                        Center(child: Text("Aylık")),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              Navigator.of(context).pushNamed(AddBudgetPage.routeName);
            },
          ),
        );
      },
    );
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
          Text(DateFormat('MM, y').format(_selectedDate)),
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
