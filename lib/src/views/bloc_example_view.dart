import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvents {}

class IncrementEvent extends CounterEvents {}

class DecrementEvent extends CounterEvents {}

class CounterState {
  final int counter;

  CounterState(this.counter);
}

class CounterBloc extends Bloc<CounterEvents, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.counter + 1));
    });

    on<DecrementEvent>((event, emit) {
      emit(CounterState(state.counter - 1));
    });
  }
}

class BlocExampleView extends StatelessWidget {
  const BlocExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Center(
              child: BlocBuilder < CounterBloc,
              CounterState >
                  {
                    builder: (context, state) {
                      return Text(
                        'Contador: ${state.counter}',
                        style: TextStyle(fontSize: 22),
                      );
                    },
                  },
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed:
                      () => {context.read<CounterBloc>().add(IncrementEvent())},
                  child: Icon(Icons.add),
                ),
                SizedBox(height: 20),
                FloatingActionButton(
                  heroTag: 'bnt2',
                  onPressed:
                      () => {context.read<CounterBloc>().add(DecrementEvent())},
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
