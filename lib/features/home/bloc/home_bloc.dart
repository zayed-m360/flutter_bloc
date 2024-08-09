import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/data/cart_list.dart';
import 'package:myapp/data/favorite_list.dart';
import 'package:myapp/features/home/model/product_data_model.dart';

import '../../../data/product_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateFavoritesEvent>(homeNavigateFavoritesEvent);
    on<HomeNavigateCartEvent>(homeNavigateCartEvent);
    on<HomeClickCartEvent>(homeClickCartEvent);
    on<HomeClickFavoritesEvent>(homeClickFavoritesEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(HomeLoadingSuccessState(product: TechProducts.techProducts.map((product)=>ProductDataModel(id: product['id'], name: product['name'], imageUrl: product['imageUrl'], price: product['price'])).toList()));
  }

  FutureOr<void> homeNavigateFavoritesEvent(HomeNavigateFavoritesEvent event, Emitter<HomeState> emit) {
    print("navigating to favorites");
    emit(HomeNavigateToFavoritesState());
  }

  FutureOr<void> homeNavigateCartEvent(HomeNavigateCartEvent event, Emitter<HomeState> emit) {
    print("navigating to cart");
    emit(HomeNavigateToCartState());
  }

  FutureOr<void> homeClickCartEvent(HomeClickCartEvent event, Emitter<HomeState> emit) {
    print("Clicked cart");
    cartList.add(event.productDataModel);
    emit(HomeClickCartState());
  }

  FutureOr<void> homeClickFavoritesEvent(HomeClickFavoritesEvent event, Emitter<HomeState> emit) {
    print("Clicked Favorites");
    favoriteList.add(event.productDataModel);
    emit(HomeClickFavoritesState());
  }

}
