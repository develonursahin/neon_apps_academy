import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/counter_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => CounterProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Provider App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${provider.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: provider.reduce, child: const Text("Reduce")),
            ElevatedButton(
                onPressed: provider.increment, child: const Text("Increment"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.reset,
        tooltip: 'reset',
        child: const Icon(Icons.restart_alt),
      ),
    );
  }
}
