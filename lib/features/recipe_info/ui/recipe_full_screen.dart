import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/theme/app_palette.dart';
import 'package:recipe_app/features/recipe_info/bloc/recipe_info_bloc.dart';
import 'package:recipe_app/features/recipe_search/models/recipe_response.dart';

class RecipeFullScreen extends StatelessWidget {
  final Result recipe;
  const RecipeFullScreen({super.key, required this.recipe});
  static route(Result result) => MaterialPageRoute(
        builder: (context) => RecipeFullScreen(
          recipe: result,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: recipe.id!,
                      child: Image.network(recipe.image!, fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image);
                      }),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
                  builder: (context, state) {
                    if (state is RecipeInfoSuccessState) {
                      return Wrap(
                        children: state.ingredients
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    width: 0.8,
                                    color: AppPallete.borderColor,
                                  ),
                                ),
                                child: Text(e),
                              ),
                            )
                            .toList(),
                      );
                    }
                    return const SizedBox(
                      height: 30,
                    );
                  },
                ),
                const Divider(),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Instructions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<RecipeInfoBloc, RecipeInfoState>(
                  builder: (context, state) {
                    if (state is RecipeInfoLoadingState) {
                      return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is RecipeInfoSuccessState) {
                      return Column(
                          children: state.instructions.steps!
                              .map((e) => Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Step: ${e.number}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(e.step ?? ""),
                                      const Divider(),
                                    ],
                                  ))
                              .toList());
                    } else if (state is RecipeInfoFailureState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
