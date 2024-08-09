part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}
class HomeLoadingSuccessState extends HomeState {
  final List<ProductDataModel> product;
  final int cartItemCount;
  final int favoriteItemCount;

  HomeLoadingSuccessState({
    required this.product,
    required this.cartItemCount,
    required this.favoriteItemCount,
  });
}

class HomeUpdateBadgeState extends HomeState {
  final int cartItemCount;
  final int favoriteItemCount;

  HomeUpdateBadgeState({
    required this.cartItemCount,
    required this.favoriteItemCount,
  });
}
class HomeLoadingErrorState extends HomeState{}

class HomeNavigateToCartState extends HomeActionState{}
class HomeNavigateToFavoritesState extends HomeActionState{}

class HomeClickFavoritesState extends HomeActionState{}
class HomeClickCartState extends HomeActionState{}
