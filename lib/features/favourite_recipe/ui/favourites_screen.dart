import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/theme/app_palette.dart';
import 'package:recipe_app/features/favourite_recipe/bloc/favourites_bloc.dart';
import 'package:recipe_app/features/recipe_info/bloc/recipe_info_bloc.dart';
import 'package:recipe_app/features/recipe_info/ui/recipe_full_screen.dart';
import 'package:recipe_app/features/recipe_search/ui/widgets/recipe_card.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const FavouritesScreen(),
      );

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  void initState() {
    context.read<FavouritesBloc>().add(FetchFavouritesEvent());
    log('fetch added');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Recipes'),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (context, state) {
          if (state is FavouritesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppPallete.gradient2,
              ),
            );
          } else if (state is FavouritesSuccess) {
            return ListView.builder(
              itemCount: state.favourites.length,
              itemBuilder: (context, index) => RecipeCard(
                result: state.favourites[index],
                onCardClick: () {
                  context.read<RecipeInfoBloc>().add(RecipeInfoClickEvent(
                        result: state.favourites[index],
                      ));
                  Navigator.push(
                      context, RecipeFullScreen.route(state.favourites[index]));
                },
              ),
            );
          } else if (state is FavouritesFailure) {
            return const Center(
              child: Text('failed to load'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
