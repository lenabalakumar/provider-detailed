part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  List<Product> products;

  CartLoaded({required this.products});
}

class CartFail extends CartState {
  String fail;

  CartFail({required this.fail});
}
