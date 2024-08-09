import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/cart/bloc/cart_bloc.dart';
import 'package:myapp/features/home/model/product_data_model.dart';

class ProductCardforCart extends StatelessWidget {
  final ProductDataModel productDataModel;
  const ProductCardforCart({super.key, required this.productDataModel});


  @override
  Widget build(BuildContext context) {
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
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
                    // IconButton(
                    //   icon: Icon(Icons.favorite_border),
                    //   onPressed: () {
                    //     // Handle favorite action
                    //     // cartBloc.add(HomeClickFavoritesEvent(productDataModel: productDataModel));
                    //   },
                    // ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.redAccent,),
                      onPressed: () {
                        // Handle remove from cart action
                        cartBloc.add(CartRemoveItemEvent(productDataModel: productDataModel));
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
