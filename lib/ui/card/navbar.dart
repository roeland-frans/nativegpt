import 'package:testtextapp/app.dart';
import 'package:flutter/material.dart';
import 'package:testtextapp/event_stream.dart';


class NavBar extends StatefulWidget{
  final MyAppState appState;
  NavBar({required this.appState});

  @override
  State<NavBar> createState() => _NavBarState();

}

class _NavBarState extends State<NavBar> {
  var eventStream = EventStream();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              'NativeGPT',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
          ),
          ListTile(
            title: const Text('Messages'),
            selected: widget.appState.selectedIndex == 0,
            onTap: () {
              // Update the state of the app
              widget.appState.onItemTapped(0);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Knowledge Base'),
            selected: widget.appState.selectedIndex == 1,
            onTap: () {
              // Update the state of the app
              widget.appState.onItemTapped(1);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            selected: widget.appState.selectedIndex == 2,
            onTap: () {
              // Update the state of the app
              widget.appState.onItemTapped(2);
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      )
    );
  }
}