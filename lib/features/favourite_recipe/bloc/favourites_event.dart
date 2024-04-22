part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {
  const FavouritesEvent();
}

class FetchFavouritesEvent extends FavouritesEvent {}

class ToggleFavouriteEvent extends FavouritesEvent {
  final Result recipe;
  const ToggleFavouriteEvent({required this.recipe});
}
