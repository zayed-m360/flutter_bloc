import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/home/model/product_data_model.dart';

import '../bloc/home_bloc.dart';

class ProductCard extends StatefulWidget {
  final ProductDataModel productDataModel;
  const ProductCard({super.key, required this.productDataModel});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.productDataModel.name.toUpperCase(),
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
                  widget.productDataModel.imageUrl,
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
                      '\$${(widget.productDataModel.price + 50).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    // New price
                    Text(
                      '\$${widget.productDataModel.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Icons for favorite and cart
                BlocBuilder<HomeBloc, HomeState>(
                  bloc: homeBloc,
                  builder: (context, state) {
                    bool isCarted = homeBloc.cartList
                        .contains(widget.productDataModel);
                    bool isFavorited = homeBloc.favoriteList
                        .contains(widget.productDataModel);
                    return Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_outline_outlined,
                          ),
                          onPressed: () {
                            isFavorited
                                ? homeBloc.add(HomeUnClickFavoritesEvent(
                                    productDataModel: widget.productDataModel))
                                :
                            homeBloc.add(HomeClickFavoritesEvent(
                                productDataModel: widget.productDataModel));
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            isCarted
                                ? Icons.shopping_bag
                                : Icons.shopping_bag_outlined,
                          ),
                          onPressed: () {
                            isCarted
                                ? homeBloc.add(HomeUnClickCartEvent(
                                    productDataModel: widget.productDataModel))
                                :
                            homeBloc.add(HomeClickCartEvent(
                                productDataModel: widget.productDataModel));
                          },
                        )
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
