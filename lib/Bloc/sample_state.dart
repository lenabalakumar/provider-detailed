part of 'sample_bloc.dart';

abstract class CounterState {}


class ToIncrementOrDecrement extends CounterState {
  int quantity;

  ToIncrementOrDecrement({required this.quantity});
}

