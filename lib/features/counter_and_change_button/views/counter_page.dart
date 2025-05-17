import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/features/counter_and_change_button/riverpod/button_provider.dart';
import 'package:riverpod_app/features/counter_and_change_button/riverpod/counter_provider.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    log("Rebuild");
    return Scaffold(
      appBar: AppBar(title: Text("Counter"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context,ref,child) {
                final counter = ref.watch(counterProvider);
                return Text("$counter",style: TextStyle(fontSize: 30),);
                //return Text("${counter.count}",style: TextStyle(fontSize: 30),);
              }
            ),

            Consumer(
              builder: (context,ref,child) {
                final button = ref.watch(buttonProvider);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap:(){
                        ref.read(buttonProvider.notifier).updateButton(value: 1);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color:  button == 1 ? Colors.blue :Colors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        ref.read(buttonProvider.notifier).updateButton(value: 2);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: button == 2 ? Colors.blue :Colors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap:(){
                        ref.read(buttonProvider.notifier).updateButton(value: 3);
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: button == 3 ? Colors.blue :Colors.red,
                      ),
                    )
                  ],
                );
              }
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(onPressed: (){
            ref.read(counterProvider.notifier).increment();
          },child: Icon(Icons.add),),
          FloatingActionButton(onPressed: (){
            ref.read(counterProvider.notifier).decrement();
          },child: Icon(Icons.remove),),
        ],
      )
    );

  }
}
