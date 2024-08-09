import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myapp/data/favorite_list.dart';
import 'package:myapp/features/home/model/product_data_model.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<FavouritesInitialEvent>(favouritesInitialEvent);
    on<FavoritesRemoveItemEvent>(favoritesRemoveItemEvent);

  }

  FutureOr<void> favouritesInitialEvent(FavouritesInitialEvent event, Emitter<FavouritesState> emit) {
    emit(FavouritesSucessState(favouritesItems: favoriteList));
  }

  FutureOr<void> favoritesRemoveItemEvent(FavoritesRemoveItemEvent event, Emitter<FavouritesState> emit) {
    favoriteList.remove(event.productDataModel);
    emit(FavouritesSucessState(favouritesItems: favoriteList));
    emit(FavouritesRemovedSuccessState());
  }
}
