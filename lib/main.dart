import 'package:flutter/material.dart';
import 'package:im_back/basic/ui.dart';
import 'package:im_back/form_bloc/ui.dart';

void main() {
  runApp(Main());
}

// MAIN
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  final List<Widget> _children = [ProviderBasic(), SignUpForm()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: _children[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text('Provider'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_ind),
              title: Text('Form Bloc'),
            )
          ],
        ),
      ),
    );
  }
}
