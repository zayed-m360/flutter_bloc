part of 'favourites_bloc.dart';

@immutable
sealed class FavouritesState {}

abstract class FavouritesActionState extends FavouritesState {}

final class FavouritesInitial extends FavouritesState {}

class FavouritesSucessState extends FavouritesState{
  final List<ProductDataModel> favouritesItems;
  FavouritesSucessState({required this.favouritesItems});
}

class FavouritesRemovedSuccessState extends FavouritesActionState{}
