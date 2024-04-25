import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/theme/app_palette.dart';
import 'package:recipe_app/features/favourite_recipe/ui/favourites_screen.dart';
import 'package:recipe_app/features/recipe_info/bloc/recipe_info_bloc.dart';
import 'package:recipe_app/features/recipe_search/bloc/recipes_bloc.dart';
import 'package:recipe_app/features/recipe_info/ui/recipe_full_screen.dart';
import 'package:recipe_app/features/recipe_search/ui/widgets/recipe_card.dart';
import 'package:recipe_app/features/recipe_search/ui/widgets/search_bar.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void initState() {
    context.read<RecipesBloc>().add(const RecipeSearchEvent(searchText: ''));

    log('done calling');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MySearchBar(
          textEditingController: searchTextEditingController,
          onPressed: () {
            context.read<RecipesBloc>().add(RecipeSearchEvent(
                  searchText: searchTextEditingController.text.trim(),
                ));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, FavouritesScreen.route());
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 30,
            ),
          )
        ],
      ),
      body: BlocConsumer<RecipesBloc, RecipesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is RecipesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppPallete.gradient2,
              ),
            );
          } else if (state is RecipesSuccessState) {
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) => RecipeCard(
                result: state.results[index],
                onCardClick: () {
                  context.read<RecipeInfoBloc>().add(RecipeInfoClickEvent(
                        result: state.results[index],
                      ));
                  Navigator.push(
                      context, RecipeFullScreen.route(state.results[index]));
                },
              ),
            );
          } else if (state is RecipesFailureState) {
            return const Center(
              child: Text('failed to load'),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
