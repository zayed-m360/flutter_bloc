import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/cart/ui/product_card_for_cart.dart';

import '../bloc/cart_bloc.dart';

class CartUi extends StatefulWidget {
  CartUi({super.key});

  @override
  State<CartUi> createState() => _CartUiState();
}

class _CartUiState extends State<CartUi> {
  late CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartRemoveSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item removed from Cart")));
          }
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) => ProductCardforCart(
                    productDataModel: successState.cartItems[index],
                  ),
                ),
              );
          }
          return Container();
        },
      ),
    );
  }
}
