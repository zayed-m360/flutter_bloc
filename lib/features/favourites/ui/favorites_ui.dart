import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/favourites/ui/product_card_for_favourites.dart';

import '../bloc/favourites_bloc.dart';

class FavoritesUi extends StatefulWidget {
  @override
  State<FavoritesUi> createState() => _FavoritesUiState();
}

class _FavoritesUiState extends State<FavoritesUi> {
  late FavouritesBloc favouritesBloc;

  @override
  void initState() {
    super.initState();
    favouritesBloc = BlocProvider.of<FavouritesBloc>(context);
    favouritesBloc.add(FavouritesInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is FavouritesRemovedSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Item Removed From Favourites")));
          }
        },
        listenWhen: (previous, current) => current is FavouritesActionState,
        buildWhen: (previous, current) => current is! FavouritesActionState,
        builder: (context, state) {
          if (state is FavouritesSucessState) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: state.favouritesItems.length,
                itemBuilder: (context, index) => ProductCardforFavourites(
                  productDataModel: state.favouritesItems[index],
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
