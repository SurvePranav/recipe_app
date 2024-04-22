import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/favourite_recipe/repos/favourites_repo.dart';
import 'package:recipe_app/features/recipe_search/models/recipe_response.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesEvent>((event, emit) {});

    on<ToggleFavouriteEvent>(_onToggleFavouriteEvent);
    on<FetchFavouritesEvent>(_onFetchFavouritesEvent);
  }

  Future<void> _onToggleFavouriteEvent(
      ToggleFavouriteEvent event, Emitter<FavouritesState> emit) async {
    try {
      log('I was called');
      await FavoritesRepository.toggleFavorite(event.recipe);
      final favourites = await FavoritesRepository.getFavorites();
      emit(FavouritesSuccess(favourites: favourites));
    } catch (e) {
      log('something went wrong');
      emit(const FavouritesFailure(errorMessage: 'could not do operation'));
    }
  }

  Future<void> _onFetchFavouritesEvent(
      FetchFavouritesEvent event, Emitter<FavouritesState> emit) async {
    try {
      emit(FavouritesLoading());
      log('I was called to fetch');
      final favourites = await FavoritesRepository.getFavorites();
      emit(FavouritesSuccess(favourites: favourites));
    } catch (e) {
      log('something went wrong');
      emit(const FavouritesFailure(errorMessage: 'could not do operation'));
    }
  }
}
