part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}
class HomeInitialEvent extends HomeEvent {}
class HomeClickFavoritesEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeClickFavoritesEvent({required this.productDataModel});
}
class HomeUnClickFavoritesEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeUnClickFavoritesEvent({required this.productDataModel});
}
class HomeClickCartEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeClickCartEvent({required this.productDataModel});
}
class HomeUnClickCartEvent extends HomeEvent {
  final ProductDataModel productDataModel;
  HomeUnClickCartEvent({required this.productDataModel});
}
class HomeNavigateFavoritesEvent extends HomeEvent {}
class HomeNavigateCartEvent extends HomeEvent {}