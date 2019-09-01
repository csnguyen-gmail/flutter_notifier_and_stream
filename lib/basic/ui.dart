import 'package:flutter/material.dart';
import 'package:im_back/basic/services.dart';
import 'package:im_back/basic/states.dart';
import 'package:provider/provider.dart';

class ProviderBasic extends StatefulWidget {
  @override
  _ProviderBasicState createState() => _ProviderBasicState();
}

class _ProviderBasicState extends State<ProviderBasic> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => BoxPoolModel(
        api: BoxApi(),
      ),
      child: Column(
        children: <Widget>[
          BoxPoolController(),
          Expanded(child: BoxPool()),
        ],
      ),
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
          child: Text('Remove Last'),
          onPressed:
          Provider.of<BoxPoolModel>(context, listen: false).removeLast,
        ),
        RaisedButton(
          child: Text('Add'),
          onPressed: Provider.of<BoxPoolModel>(context, listen: false).add,
        ),
      ],
    );
  }
}

// BOX POOL
class BoxPool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoxPoolModel>(
      builder: (context, pool, child) {
        print("Pool");
        return GridView.count(
          crossAxisCount: 2,
          children: List.generate(pool.items.length, (index) {
            return ChangeNotifierProvider.value(
              value: pool.items[index],
              child: Box(),
            );
          }),
        );
      },
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
    );
  }
}

