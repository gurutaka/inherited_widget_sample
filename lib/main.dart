import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomePage(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Inherited Widget Sampel"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WidgetNumText(),
                WidgetCenterText(),
              ],
            ),
          ),
          floatingActionButton: WidgetIncrementBtn(),
        ),
      ),
    );
  }
}

class _InheritedWidget extends InheritedWidget {
  const _InheritedWidget({
    Key key,
    Widget child,
    this.data,
  }) : super(key: key, child: child);

  final HomePageState data;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  HomePageState createState() => HomePageState();

  static HomePageState of(BuildContext context, {bool rebuild = true}) {
    return rebuild
        ? (context.inheritFromWidgetOfExactType(_InheritedWidget)
                as _InheritedWidget)
            .data
        : (context
                .ancestorInheritedElementForWidgetOfExactType(_InheritedWidget)
                .widget as _InheritedWidget)
            .data;
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWidget(
      child: widget.child,
      data: this,
    );
  }
}

class WidgetNumText extends StatelessWidget {
  const WidgetNumText({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context);
    return Text(
      '${state.counter}',
      style: Theme.of(context).textTheme.display1,
    );
  }
}

class WidgetCenterText extends StatelessWidget {
  const WidgetCenterText({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('You have pushed the button this many times:');
  }
}

class WidgetIncrementBtn extends StatelessWidget {
  const WidgetIncrementBtn({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final HomePageState state = HomePage.of(context, rebuild: false);
    return FloatingActionButton(
      onPressed: () => state._incrementCounter(),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
