import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/cart/bloc/cart_bloc.dart';
import 'package:myapp/features/home/model/product_data_model.dart';

import '../../favourites/bloc/favourites_bloc.dart';
import '../bloc/home_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductCard({super.key, required this.productDataModel});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image and title on the side
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    productDataModel.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Image.network(
                  productDataModel.imageUrl,
                  fit: BoxFit.contain,
                  height: 100,
                ),
              ),
            ],
          ),
          // Price and icons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${(productDataModel.price+50).toStringAsFixed(2)}', 
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    // New price
                    Text(
                      '\$${productDataModel.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Icons for favorite and cart
                Row(
                  children: [
                    BlocBuilder<FavouritesBloc, FavouritesState>(
                      builder: (context, state) {
                        bool isFavorited = false;
                        if (state is FavouritesSucessState) {
                          isFavorited = state.favouritesItems.contains(productDataModel);
                        }
                        return IconButton(
                          icon: Icon(
                            isFavorited ? Icons.favorite : Icons.favorite_border,
                          ),
                          onPressed: () {
                            homeBloc.add(HomeClickFavoritesEvent(productDataModel: productDataModel));
                          },
                        );
                      },
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        bool isInCart = false;
                        if (state is CartSuccessState) {
                          isInCart = state.cartItems.contains(productDataModel);
                        }
                        return IconButton(
                          icon: Icon(
                            isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined,
                          ),
                          onPressed: () {
                            homeBloc.add(HomeClickCartEvent(productDataModel: productDataModel));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
