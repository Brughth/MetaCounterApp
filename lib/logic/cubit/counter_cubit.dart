import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit() : super(CounterState(counter: 0));

  void increment() => emit(CounterState(counter: state.counter + 1));
  void decrement() => emit(CounterState(counter: state.counter - 1));

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return CounterState.fromMap(json);
    }
    return CounterState(counter: 0);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }
}
