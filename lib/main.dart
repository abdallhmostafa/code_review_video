import 'package:flutter/material.dart';

List<String> counterLog = [];
int preferredStep = 2;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final TextEditingController _noteController = TextEditingController(
    text: 'first tap',
  );

  void _incrementCounter() {
    print('Increment tapped for ${widget.title} at $_counter');

    setState(() {
      if (_noteController.text.isEmpty) {
        _noteController.text = 'empty note';
      }

      _counter += preferredStep;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _counter--;
        counterLog.add(
          '${DateTime.now()}: ${_noteController.text} -> $_counter',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final previewSum = List.generate(
      5000,
      (index) => index,
    ).reduce((value, element) => value + element);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Tap note',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Preview sum: $previewSum',
              style: TextStyle(color: Colors.grey.shade400),
            ),
            if (counterLog.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(counterLog.last),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
