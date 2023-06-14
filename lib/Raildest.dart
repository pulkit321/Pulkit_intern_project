import 'package:flutter/material.dart';
import 'package:try1/mainpage.dart';
import 'package:try1/Accounts.dart';
import 'package:try1/usermanagement.dart';
import 'package:try1/Activitylog.dart';
import 'package:cmutil/cmutil.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'dart:ui';

class MyNavigationRail extends StatefulWidget {
  const MyNavigationRail({Key? key}) : super(key: key);

  @override
  _MyNavigationRailState createState() => _MyNavigationRailState();
}

class _MyNavigationRailState extends State<MyNavigationRail> {
  int _selectedIndex = 0;
  List<Widget> _screens = [
    Container(
        child: Image.asset("assets/images/img.png", alignment: Alignment.center)
    ),
  ];


  final List<NavigationRailDestination> _destinations = [
    NavigationRailDestination(
      icon:Image.asset('assets/images/img.png'),
      label: Text(''),
    ),

    NavigationRailDestination(
      icon: Icon(Icons.ad_units_rounded),
      label: Text('Consents'),
    ),
    NavigationRailDestination(
        icon: Icon(Icons.account_balance_outlined),
        label: Text('Account')),
    NavigationRailDestination(
        icon: Icon(Icons.account_circle), label: Text('User Management')
    ),
    NavigationRailDestination(
        icon: Icon(Icons.access_time_rounded), label: Text('Activity Log')
    ),

    NavigationRailDestination(
        padding:EdgeInsets.only(top:250,left:65),

        icon: Icon(Icons.keyboard_double_arrow_left),
        label: Text('')
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(

        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: _destinations,
          ),

          Expanded(
            child: Stack(
              children: [

                Visibility(
                  visible: _selectedIndex == 1, child: Text(''),
                  // child: MainnPage(response.headers["set-cookie"]),
                ),
                Visibility(
                    visible: _selectedIndex == 2,
                    child: Account()
                ),

                Visibility(
                    visible: _selectedIndex == 3,
                    child: usermanagement()
                ),

                Visibility(
                    visible: _selectedIndex == 4,
                    child: Activitylog()
                ),
                SizedBox(height:259),
              ],
            ),
          ),
        ],
      ),
    );
  }
}