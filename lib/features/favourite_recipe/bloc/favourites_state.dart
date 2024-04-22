part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {
  const FavouritesState();
}

final class FavouritesInitial extends FavouritesState {}

final class FavouritesSuccess extends FavouritesState {
  final List<Result> favourites;

  const FavouritesSuccess({required this.favourites});
}

final class FavouritesLoading extends FavouritesState {}

final class FavouritesFailure extends FavouritesState {
  final String errorMessage;

  const FavouritesFailure({required this.errorMessage});
}
