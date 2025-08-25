import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_flutter/flutter/state_management/bloc/bloc_event.dart';
import 'package:learning_flutter/flutter/state_management/bloc/bloc_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0, false)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.count + 1, true));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterState(state.count - 1, false));
    });
  }
}
