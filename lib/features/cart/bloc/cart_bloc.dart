import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/data/cart_list.dart';

import '../../home/model/product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveItemEvent>(cartRemoveItemEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartList));
  }

  FutureOr<void> cartRemoveItemEvent(CartRemoveItemEvent event, Emitter<CartState> emit) {
    cartList.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartList));
    emit(CartRemoveSuccessState());
  }
}
