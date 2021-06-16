import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:provider_detailed/Model/productModel.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded(products: []));

  List<Product> cartProduct = [];

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    yield CartInitial();

    try {
      if (event is AddToCart) {

          cartProduct.add(event.prod);
        // Product found = cartProduct.firstWhere((element) => element.productID == event.prod.productID);
        // found.productQuantity

          // print('inside isEmpty ${event.prod.productID}');
          // Product found = cartProduct.firstWhere(
          //         (element) => element.productID == event.prod.productID,
          //     orElse: null);
          // int.parse(found.productQuantity) + 1;
          // print('updated product quantity ${int.parse(found.productQuantity) + 1}');
          // print('inside else block ${event.prod.productID}');

      } else if (event is DeleteCart) {
        cartProduct.remove(event.prod);
        print(cartProduct);
      }
      yield CartLoaded(products: cartProduct);
    } catch (e) {
      yield CartFail(fail: e.toString());
    }
  }


}
