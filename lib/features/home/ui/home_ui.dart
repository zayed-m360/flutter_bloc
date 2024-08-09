import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/home/ui/product_card.dart';
import '../../cart/cart_ui.dart';
import '../../favorites/favorites_ui.dart';
import '../bloc/home_bloc.dart';

class HomeUi extends StatefulWidget {
  HomeUi({super.key});

  @override
  State<HomeUi> createState() => _HomeUiState();
}

class _HomeUiState extends State<HomeUi> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) =>
          current is! HomeActionState || current is HomeUpdateBadgeState,
      listener: (context, state) {
        if (state is HomeNavigateToFavoritesState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesUi()));
        } else if (state is HomeNavigateToCartState) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartUi()));
        } else if (state is HomeClickCartState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Item added to Cart"),
            duration: Duration(milliseconds: 300),
          ));
        } else if (state is HomeClickFavoritesState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Item added to Favorites"),
            duration: Duration(milliseconds: 300),
          ));
        }
      },
      builder: (context, state) {
        int cartItemCount = homeBloc.cartList.length;
        int favoriteItemCount = homeBloc.favoriteList.length;

        if (state is HomeLoadingSuccessState) {
          cartItemCount = state.cartItemCount;
          favoriteItemCount = state.favoriteItemCount;
        } else if (state is HomeUpdateBadgeState) {
          cartItemCount = state.cartItemCount;
          favoriteItemCount = state.favoriteItemCount;
        }

        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            forceMaterialTransparency: true,
            title: Text("Products"),
            actions: [
              Badge(
                label: Text('$favoriteItemCount'),
                child: IconButton(
                  onPressed: () {
                    homeBloc.add(HomeNavigateFavoritesEvent());
                  },
                  icon: Icon(Icons.favorite_border_rounded),
                ),
              ),
              Badge(
                label: Text('$cartItemCount'),
                child: IconButton(
                  onPressed: () {
                    homeBloc.add(HomeNavigateCartEvent());
                  },
                  icon: Icon(Icons.shopping_bag_outlined),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
          body: state is HomeLoadingState
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: homeBloc.allProducts.length,
                    itemBuilder: (context, index) => ProductCard(
                        productDataModel: homeBloc.allProducts[index]),
                  ),
                ),
        );
      },
    );
  }
}
