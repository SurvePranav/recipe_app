part of 'recipe_info_bloc.dart';

@immutable
sealed class RecipeInfoEvent {
  const RecipeInfoEvent();
}

class RecipeInfoClickEvent extends RecipeInfoEvent {
  final Result result;
  const RecipeInfoClickEvent({
    required this.result,
  });
}
