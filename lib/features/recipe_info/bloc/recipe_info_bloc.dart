import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/recipe_info/models/recipe_instruction_model.dart';
import 'package:recipe_app/features/recipe_info/repo/recipe_info_repo.dart';
import 'package:recipe_app/features/recipe_search/models/recipe_response.dart';

part 'recipe_info_event.dart';
part 'recipe_info_state.dart';

class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  RecipeInfoBloc() : super(RecipeInfoInitial()) {
    on<RecipeInfoEvent>((event, emit) {
      emit(RecipeInfoLoadingState());
    });
    on<RecipeInfoClickEvent>(_onRecipeClickEvent);
  }

  Future _onRecipeClickEvent(
      RecipeInfoClickEvent event, Emitter<RecipeInfoState> emit) async {
    try {
      log('fetching data');
      final response = await RecipeInfoRepo.fetchRecipeInformationById(
          '${event.result.id!}');

      List<String> ingredients = [];
      for (int i = 0; i < response.first.steps!.length; i++) {
        for (int j = 0; j < response.first.steps![i].ingredients!.length; j++) {
          final ingredient = response.first.steps![i].ingredients![j].name;
          if (ingredient != null) {
            ingredients.add(ingredient);
          }
        }
      }
      // Convert list to set to remove duplicates
      ingredients = Set<String>.from(ingredients).toList();

      emit(
        RecipeInfoSuccessState(
          ingredients: ingredients,
          instructions: response.first,
        ),
      );
    } catch (e) {
      emit(
          const RecipeInfoFailureState(message: 'could not load instructions'));
    }
  }
}
