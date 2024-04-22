part of 'recipes_bloc.dart';

@immutable
sealed class RecipesState {
  const RecipesState();
}

final class RecipesInitial extends RecipesState {}

final class RecipesLoadingState extends RecipesState {}

final class RecipesSuccessState extends RecipesState {
  final List<Result> results;
  final RecipeInstructionsModel? instructions;
  const RecipesSuccessState({required this.results, this.instructions});
}

final class RecipesFailureState extends RecipesState {
  final String errorMessage;

  const RecipesFailureState({required this.errorMessage});
}
