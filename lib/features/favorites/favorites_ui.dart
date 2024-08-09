import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/home/bloc/home_bloc.dart';

import '../home/ui/product_card.dart';

class FavoritesUi extends StatefulWidget {
  const FavoritesUi({super.key});

  @override
  State<FavoritesUi> createState() => _FavoritesUiState();
}

class _FavoritesUiState extends State<FavoritesUi> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: homeBloc.favoriteList.length,
              itemBuilder: (context, index) =>
                  ProductCard(productDataModel: homeBloc.favoriteList[index]),
            ),
          );
        },
      ),
    );
  }
}
