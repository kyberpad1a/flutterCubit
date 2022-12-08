import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_cubit/cubit/test_cubit.dart';

import 'cubit/list_view_cubit.dart';
import 'cubit/theme_cubit_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'cubit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TestCubit()),
            BlocProvider(create: (context) => ListViewCubit()),
            BlocProvider(create: (context) => ThemeCubitCubit())
          ],
          child: BlocBuilder<ThemeCubitCubit, ThemeData>(
            builder: (context, state) {
              return MaterialApp(
                theme: state,
                home: MyHomePage(),
              );
            },
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // title: Text(),
          ),
      body: Row(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocConsumer<TestCubit, TestState>(
                listener: (context, state) {
                  if (state is TestError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error.toString())));
                  }
                },
                builder: (context, state) {
                  if (state is TestClick) {
                    return Text(state.count.toString());
                  }
                  return Text('Нажмите на кнопку');
                },
              ),
            ],
          ),
        ),
        
          Column(
            children: [
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(500, 0, 0, 0),
                  child: SizedBox(
                    height: 150,
                    width: 500,
                    child: BlocBuilder<ListViewCubit, ListViewInitial>(
                        builder: (context, state) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.all(8),
                          itemCount: context
                              .read<ListViewCubit>()
                              .state
                              .clickHistory
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(index.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${context.read<ListViewCubit>().state.clickHistory[index]}'),
                                ),
                              ],
                            );
                          });
                    }),
                  ),
                ),
              ),
            ],
          ),
        
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
        child: Row(children: [
          FloatingActionButton(
            onPressed: (() {
               if (context.read<ThemeCubitCubit>().state==ThemeData.dark())
               {
                  context.read<TestCubit>().increment();
                  context.read<TestCubit>().increment();
                  context.read<ListViewCubit>().listAdd("(+2)");
                  
               }
               else
               {context.read<TestCubit>().increment();
               context.read<ListViewCubit>().listAdd("(+1)");}
               
            }), 
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
              onPressed: ((){
                if (context.read<ThemeCubitCubit>().state==ThemeData.dark())
                  {context.read<TestCubit>().decrement();
                  context.read<TestCubit>().decrement();
                  context.read<ListViewCubit>().listAdd("(-2)");}
                else
                {context.read<TestCubit>().decrement();
                context.read<ListViewCubit>().listAdd("(-1)");}

              }),
              tooltip: 'Decrement',
              child: const Icon(Icons.minimize)),
          FloatingActionButton(
            onPressed: (() => context.read<ThemeCubitCubit>().themeSwitch()),
            tooltip: 'Theme',
            child: const Icon(Icons.wb_sunny_outlined),
          )
        ]),
      ),
    );
  }
}
