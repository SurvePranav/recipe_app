import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/core/constants/favourite_recipes.dart';
import 'package:recipe_app/core/theme/theme.dart';
import 'package:recipe_app/features/favourite_recipe/bloc/favourites_bloc.dart';
import 'package:recipe_app/features/favourite_recipe/repos/favourites_repo.dart';
import 'package:recipe_app/features/recipe_info/bloc/recipe_info_bloc.dart';
import 'package:recipe_app/features/recipe_search/bloc/recipes_bloc.dart';
import 'package:recipe_app/features/recipe_search/ui/recipes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  favouritesList = await FavoritesRepository.getFavoritesId();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => RecipesBloc(),
      ),
      BlocProvider(
        create: (context) => RecipeInfoBloc(),
      ),
      BlocProvider(
        create: (context) => FavouritesBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Finder',
      theme: AppTheme.darkThemeMode,
      home: const RecipesScreen(),
    );
  }
}
