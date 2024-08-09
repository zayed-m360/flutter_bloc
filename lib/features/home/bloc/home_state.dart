part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState{}
class HomeLoadingSuccessState extends HomeState{
  final List<ProductDataModel> product;
  HomeLoadingSuccessState({required this.product});
}
class HomeLoadingErrorState extends HomeState{}

class HomeNavigateToCartState extends HomeActionState{}
class HomeNavigateToFavoritesState extends HomeActionState{}

class HomeClickFavoritesState extends HomeActionState{}
class HomeClickCartState extends HomeActionState{}