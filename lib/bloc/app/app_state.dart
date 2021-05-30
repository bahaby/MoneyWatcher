part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final List<Category> categories;
  AppLoaded({
    required this.categories,
  });
  @override
  List<Object> get props => [categories];
}
