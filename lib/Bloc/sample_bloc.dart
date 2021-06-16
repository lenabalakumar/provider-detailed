import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sample_event.dart';
part 'sample_state.dart';

class SampleBloc extends Bloc<CounterEvent, CounterState> {
  SampleBloc() : super(ToIncrementOrDecrement(quantity: 0));

  int counter = 0;

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    try {
      if (event is IncrementEvent) {
        counter += 1;
      }
      else if (event is DecrementEvent){
        counter -= 1;
      }
      yield ToIncrementOrDecrement(quantity: 0);

    } catch (e) {}
  }

  // int incrementCounter(int counter) => counter++;
  // int decrementCounter(int counter) => counter--;
}
