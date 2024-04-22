import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:recipe_app/core/secrets/app_secrets.dart';
import 'package:recipe_app/features/recipe_info/models/recipe_instruction_model.dart';

class RecipeInfoRepo {
  // fetching recipe info by id
  static Future<List<RecipeInstructionsModel>> fetchRecipeInformationById(
      String id) async {
    try {
      List<RecipeInstructionsModel> recipeInstructions = [];
      final http.Response res = await http.get(Uri.parse(
          '${AppSecrets.recipeInstructionsUrl}/$id/analyzedInstructions?apiKey=${AppSecrets.apiKey}'));
      if (res.statusCode == 200) {
        final List<RecipeInstructionsModel> response =
            recipeInstructionsModelFromJson(res.body);
        recipeInstructions = response;
        log('got instructions: ${response.first.steps!.length}');
      } else {
        throw Exception('could not load recipe');
      }
      return recipeInstructions;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
