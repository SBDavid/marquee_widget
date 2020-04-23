import 'package:flutter/material.dart';
import 'package:flutter_marquee_widget/flutter_marquee_widget.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Color> list;

  @override
  void initState() {
    super.initState();
    list = [
      Colors.lightBlue,
      Colors.red,
      Colors.indigoAccent,
      Colors.green,
      Colors.lightGreen,
    ];
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = list.map((color) {
      return Container(
        constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          color: color,
        ),
        child: Center(

        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 50,
          width: 300,
          child: FlutterMarqueeWidget(items, initialItemCount: 4,)
        ),
      ),
    );
  }
}
