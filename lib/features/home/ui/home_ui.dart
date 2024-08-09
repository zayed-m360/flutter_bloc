import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/cart/ui/cart_ui.dart';
import 'package:myapp/features/favourites/ui/favorites_ui.dart';
import 'package:myapp/features/home/ui/product_card.dart';
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
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToFavoritesState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoritesUi()));
        }else if (state is HomeNavigateToCartState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartUi()));
        }else if(state is HomeClickCartState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to Cart")));
        }else if(state is HomeClickFavoritesState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item added to Favorites")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType){
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadingSuccessState:
            final successState = state as HomeLoadingSuccessState;
            return Scaffold(
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0.0,
                forceMaterialTransparency: true,
                title: Text("Products"),
                actions: [
                  IconButton(onPressed: (){
                    homeBloc.add(HomeNavigateFavoritesEvent());
                  }, icon: Icon(Icons.favorite_border_rounded)),
                  IconButton(onPressed: (){
                    homeBloc.add(HomeNavigateCartEvent());
                  }, icon: Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: successState.product.length,
                  itemBuilder: (context, index) => ProductCard(productDataModel: successState.product[index]),
                ),
              ),
            );
          case HomeLoadingErrorState:
            return Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          default:
            return Scaffold(
              body: Center(
                child: Text("Something went wrong"),
              ),
            );

        }
      },
    );
  }
}
