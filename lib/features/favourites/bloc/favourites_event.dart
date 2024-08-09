part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesEvent {}

class FavouritesInitialEvent extends FavouritesEvent {}

class FavoritesRemoveItemEvent extends FavouritesEvent {
  final ProductDataModel productDataModel;

  FavoritesRemoveItemEvent({required this.productDataModel});
}

