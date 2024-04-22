part of 'recipes_bloc.dart';

@immutable
sealed class RecipesEvent {
  const RecipesEvent();
}

class RecipeSearchEvent extends RecipesEvent {
  final String searchText;
  const RecipeSearchEvent({required this.searchText});
}
