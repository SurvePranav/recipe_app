import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/recipe_info/models/recipe_instruction_model.dart';
import 'package:recipe_app/features/recipe_search/models/recipe_response.dart';
import 'package:recipe_app/features/recipe_search/repos/recipe_repo.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  RecipesBloc() : super(RecipesInitial()) {
    on<RecipesEvent>((event, emit) {
      emit(RecipesLoadingState());
    });

    on<RecipeSearchEvent>(_onRecipeSearchEvent);
  }

  FutureOr<void> _onRecipeSearchEvent(
      RecipeSearchEvent event, Emitter<RecipesState> emit) async {
    try {
      final response = await RecipeRepo.fetchRecipesByQuery(event.searchText);
      emit(RecipesSuccessState(results: response));
    } catch (e) {
      emit(RecipesFailureState(errorMessage: e.toString()));
    }
  }
}
