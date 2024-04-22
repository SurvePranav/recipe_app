import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/constants/favourite_recipes.dart';
import 'package:recipe_app/core/theme/app_palette.dart';
import 'package:recipe_app/features/favourite_recipe/bloc/favourites_bloc.dart';
import 'package:recipe_app/features/recipe_search/models/recipe_response.dart';

class RecipeCard extends StatefulWidget {
  final VoidCallback onCardClick;
  final Result result;
  const RecipeCard(
      {super.key, required this.result, required this.onCardClick});

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(16).copyWith(bottom: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: widget.result.id!,
                child: Image.network(
                  widget.result.image!,
                  height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.onCardClick,
          child: Container(
            height: 200,
            margin: const EdgeInsets.all(16).copyWith(bottom: 4),
            padding: const EdgeInsets.all(16.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppPallete.backgroundColor.withOpacity(0.7),
                AppPallete.transparentColor.withOpacity(0.2),
                AppPallete.transparentColor.withOpacity(0.1),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.result.title!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: AppPallete.gradient2,
                      child: BlocBuilder<FavouritesBloc, FavouritesState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () {
                              context.read<FavouritesBloc>().add(
                                    ToggleFavouriteEvent(
                                      recipe: widget.result,
                                    ),
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: favouritesList
                                          .contains(widget.result.id!)
                                      ? const Text('Removed From favourites')
                                      : const Text('Added to favourites'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                              setState(() {});
                            },
                            icon: favouritesList.contains(widget.result.id!)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  )
                                : const Icon(Icons.favorite_border),
                          );
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
