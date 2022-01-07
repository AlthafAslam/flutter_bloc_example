import 'package:flutter/material.dart';
import 'package:jify_flutter_app/src/ui/image_search.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search images'),
        actions: [
          IconButton(
            icon: AnimatedIcon(
              icon: AnimatedIcons.search_ellipsis,
              progress: ImageSearchDelegate().transitionAnimation,
            ),
            onPressed: () async {
              final _images = await showSearch(context: context, delegate: ImageSearchDelegate());
              if (_images != null) {
                Navigator.pop(context, _images);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
