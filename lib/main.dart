import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Builder',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 74),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Stream<int> fakeStream = (() async* {
  await Future.delayed(const Duration(seconds: 4));
  yield 1;
  await Future.delayed(const Duration(seconds: 1));
  yield 2;
  await Future.delayed(const Duration(seconds: 1));
  yield 3;
  await Future.delayed(const Duration(seconds: 1));
  throw 'Error on get data';
})();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Builder'),
      ),
      body: Center(
        child: StreamBuilder(
          initialData: 0,
          stream: fakeStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            if ((snapshot.hasError) || (!snapshot.hasData)) {
              return Text('Error: ${snapshot.error.toString()}');
            }
            return Text('${snapshot.data}');
          },
        ),
      ),
    );
  }
}
