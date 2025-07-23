import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'

class CounterCubit extends Cubit<init> {

    CounterCubit : super (0);

    void increment() => emit(state +1);
    void decrement() => emit(state - 1);
}
 
class CounterState {
  final int counter; 

  CounterState({required this.counter});
}

class CounterPage extends StatelessWidget {
    const CounterPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
             child: BlocBuilder<CounterCubit, int>(
                builder: (context, count) {
                 return Text('Valor: $$count');
                },
             ),
            ),
            floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    FloatingActionButton(
                        heroTage: 'decrement',
                        onPressed: () => context.read<CounterCubit().decrement(),
                        child: Icon(Icons.remove),
                    )
                    SizedBox(hegith: 20),
                    FloatingActionButton(
                        heroTag: 'increment',
                        onPressed: () => context.read<CounterCubit>().increment(),
                        child: Icon(Icons.add),
                    )
                ],
            ),
        );
    }
}