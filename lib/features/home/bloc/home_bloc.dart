import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/features/home/model/product_data_model.dart';

import '../../../data/product_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  List<ProductDataModel> allProducts = [];
  List<ProductDataModel> cartList = [];
  List<ProductDataModel> favoriteList = [];
  int cartItemCount = 0;
  int favoriteItemCount = 0;

  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateFavoritesEvent>(homeNavigateFavoritesEvent);
    on<HomeNavigateCartEvent>(homeNavigateCartEvent);
    on<HomeClickCartEvent>(homeClickCartEvent);
    on<HomeUnClickCartEvent>(homeUnClickCartEvent);
    on<HomeClickFavoritesEvent>(homeClickFavoritesEvent);
    on<HomeUnClickFavoritesEvent>(homeUnClickFavoritesEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async{
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 2));
    allProducts = TechProducts.techProducts.map((product)=>ProductDataModel(id: product['id'], name: product['name'], imageUrl: product['imageUrl'], price: product['price'])).toList();
    // emit(HomeLoadingSuccessState(product: allProducts, cartItemCount: 0, favoriteItemCount: 0));
    emit(HomeLoadingSuccessState());
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
    cartList.add(event.productDataModel);
    cartItemCount ++;
    emit(HomeUpdateBadgeState());
  }

  FutureOr<void> homeUnClickCartEvent(HomeUnClickCartEvent event, Emitter<HomeState> emit) {
    cartList.remove(event.productDataModel);
    cartItemCount --;
    emit(HomeUpdateBadgeState());
    // emit(HomeUpdateBadgeState(cartItemCount: cartList.length, favoriteItemCount: favoriteList.length));
  }

  FutureOr<void> homeClickFavoritesEvent(HomeClickFavoritesEvent event, Emitter<HomeState> emit) {
    favoriteList.add(event.productDataModel);
    favoriteItemCount ++;
    emit(HomeUpdateBadgeState());
    // emit(HomeUpdateBadgeState(cartItemCount: cartList.length, favoriteItemCount: favoriteList.length));
  }

  FutureOr<void> homeUnClickFavoritesEvent(HomeUnClickFavoritesEvent event, Emitter<HomeState> emit) {
    favoriteList.remove(event.productDataModel);
    favoriteItemCount --;
    emit(HomeUpdateBadgeState());
    // emit(HomeUpdateBadgeState(cartItemCount: cartList.length, favoriteItemCount: favoriteList.length));
  }
}
