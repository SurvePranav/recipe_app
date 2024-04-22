part of 'recipe_info_bloc.dart';

@immutable
sealed class RecipeInfoState {
  const RecipeInfoState();
}

final class RecipeInfoInitial extends RecipeInfoState {}

final class RecipeInfoSuccessState extends RecipeInfoState {
  final RecipeInstructionsModel instructions;
  final List<String> ingredients;

  const RecipeInfoSuccessState(
      {required this.ingredients, required this.instructions});
}

final class RecipeInfoFailureState extends RecipeInfoState {
  final String message;

  const RecipeInfoFailureState({required this.message});
}

final class RecipeInfoLoadingState extends RecipeInfoState {}
