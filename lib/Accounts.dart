import 'package:flutter/material.dart';
import 'package:try1/main.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:try1/login1.dart';

import 'dart:ui';

import 'package:cmutil/cmutil.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _MainnPageState();
}

class _MainnPageState extends State<Account> {
  @override
  final List<Widget> _screens = [
    // Content for Home tab
    Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(fontSize: 40),

      ),

    ),
    // Content for Feed tab
    Container(
      // child: Image.asset("assets/images/img.png", alignment: Alignment.center)
    ),

  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(



        body: Column(

          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Image.asset("assets/images/img.png", scale: 0.8),
                    //_menuItem(title: '   ', isActive: false),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'ACCOUNT', style: TextStyle(fontSize: 32),
                      ),
                    ),
                    //_menuItem(title: 'ACCOUNTS ', isActive: false),
                    // _menuItem(
                    //     title: '                                                                                                                                                                                                                                                                      ',
                    //     isActive: false),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          _menuItem(
                              title: 'Help and policies        ', isActive: true),
                          _menuItem(
                              title: 'Pulkit Kohli', isActive: true),
                        ],
                      ),
                    ),
                    //_menuItem(title: 'User', isActive: true),


                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                ],
              ),
              Divider(),
              Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Table(


                    textDirection: TextDirection.ltr,
                    defaultVerticalAlignment: TableCellVerticalAlignment.top,
                    border:TableBorder.all(width: 2.0,color: Colors.black),

                  )
              ),


            ]

        )
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false}) {
    return MouseRegion(

      cursor: SystemMouseCursors.click,
      child: Column(
        children: [
          Text(
            '$title',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.deepPurple : Colors.grey,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          isActive
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
            ),
          )
              : SizedBox()
        ],
      ),
    );
  }
  Widget _registerButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 8,
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}