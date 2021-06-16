part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddToCart extends CartEvent{
  Product prod;

  AddToCart({required this.prod});
}

class DeleteCart extends CartEvent{
  Product prod;

  DeleteCart({required this.prod});
}
