import 'package:flutter/material.dart';
import 'package:im_back/states.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(Main());
}


// MAIN
class Main extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiProvider(
        providers: [
          Provider(builder: (_) => ErrorModel()),
          ChangeNotifierProxyProvider<ErrorModel, BoxPoolModel>(
            initialBuilder: null,
            builder: (_, error, __) => BoxPoolModel(errorModel: error), // inject ErrorModel to BoxPoolModel
          ),
        ],
        child: Scaffold(
          body: Body(),
        ),
      ),
    );
  }
}

// BODY
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Body will response handle showing error
  @override
  void initState() {
    super.initState();
    var errorModel = Provider.of<ErrorModel>(context, listen: false);
    errorModel.addListener(_showError);
  }

  @override
  void dispose() {
    super.dispose();
    var errorModel = Provider.of<ErrorModel>(context, listen: false);
    errorModel.removeListener(_showError);
  }

  void _showError() {
    var errorModel = Provider.of<ErrorModel>(context, listen: false);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(errorModel.content),));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(child: BoxPool()),
          BoxPoolController(),
        ],
      ),
    );
  }
}

// BOX POOL HEADER
class BoxPoolHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Header");
    return Text ("BOX POOL");
  }
}

// BOX POOL
class BoxPool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoxPoolModel>(
      builder: (context, pool, child) {
        print("Pool");
        return Column(
          children: [
            child, // Use SomeExpensiveWidget here, without rebuilding every time.
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(pool.items.length, (index) {
                  return ChangeNotifierProvider.value(
                    value: pool.items[index],
                    child: Box(),
                  );
                }),
              ),
            ),
          ],
        );
      },
      child: BoxPoolHeader(),
    );
  }
}

// BOX
class Box extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoxModel>(
      builder: (context, box, _) {
        print("Box");
        if (box.color == null) {
          return Center(child: CircularProgressIndicator());
        }
        return GestureDetector(
          onTap: () => Provider.of<BoxPoolModel>(context, listen: false).updateBox(box),
          child: Center(
            child: Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: box.color,
              ),
            ),
          ),
        );
      },
      child: BoxPoolHeader(),
    );
  }
}

// BOX CONTROLLER
class BoxPoolController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          child: Text('-'),
          onPressed: Provider.of<BoxPoolModel>(context, listen: false).removeLast,
        ),
        RaisedButton(
          child: Text('+'),
          onPressed: Provider.of<BoxPoolModel>(context, listen: false).add,
        ),
      ],
    );
  }
}


