part of 'budget_detail_bloc.dart';

abstract class BudgetDetailState extends Equatable {
  const BudgetDetailState();

  @override
  List<Object> get props => [];
}

class BudgetDetailInitial extends BudgetDetailState {}

class BudgetDetailLoading extends BudgetDetailState {}

class BudgetDetailLoaded extends BudgetDetailState {
  final Budget budget;

  BudgetDetailLoaded({required this.budget});

  BudgetDetailLoaded copyWith({
    Budget? budget,
  }) {
    return BudgetDetailLoaded(
      budget: budget ?? this.budget,
    );
  }

  @override
  List<Object> get props => [budget];
}
