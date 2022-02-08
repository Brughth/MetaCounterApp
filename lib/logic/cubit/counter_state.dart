part of 'counter_cubit.dart';

class CounterState {
  final int counter;

  CounterState({required this.counter});

  Map<String, dynamic> toMap() {
    return {
      'counter': counter,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counter: map['counter']?.toInt() ?? 0,
    );
  }
}
