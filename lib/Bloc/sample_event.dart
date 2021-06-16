part of 'sample_bloc.dart';

@immutable
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {
  int quantity;

  IncrementEvent({required this.quantity});
}

class DecrementEvent extends CounterEvent {
  int quantity;

  DecrementEvent({required this.quantity});
}



