import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:try1/main.dart';
import 'dart:convert';
import 'package:cmutil/cmutil.dart';
import 'package:try1/mainpage.dart';
import 'dart:io';

import 'Raildest.dart';

class submitlogin extends StatefulWidget {
  //ccokie variable
  String cookie;
  submitlogin(this.cookie);
  @override
  State<submitlogin> createState() => _submitState();
}

class _submitState extends State<submitlogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Submit Page',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(widget.cookie),
    );
  }
}

class HomePage extends StatefulWidget {
  String cookie;
  HomePage(this.cookie);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void error(FormatException err) {
    print("error" + err.toString());
  }
  Future fetchConsents(dynamic context) async {
    Cookie head=Cookie.fromSetCookieValue(widget.cookie);
    print(head.value);
    print(head.name);

    dynamic response = await Cmutil.jsonRequest(
      method: "post",
      url_path: "customer/login/otp/verify-otp",
      header: {
        "Accept": "application/json",
        "connection":"Keep-Alive",
        "Content-Type": "application/json",
        "Cookie": "${head.name}=${head.value}"
      },

      body: {

        "otp":_otp
      },
      error: error,

    );
    // request.headers.addAll(header);
    print("cookie content         ${widget.cookie}");
    print("Headers    ${response.headers}");
    print(jsonDecode(response.body));

    print("Headers    ${response.headers}");
    print(response.statusCode);
    if (response.statusCode == 200) {
      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MainnPage(response.headers["set-cookie"]),
          ));

    }
    else {
      print("error");
    }
  }
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  // This is the entered code
  // It will be displayed in a Text widget
  late String _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tally Edge Verification'),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Implement 4 input fields
            SizedBox(width: 70,),
            Image.asset(
              'assets/images/illustration-2.png',
              fit: BoxFit.fill,

              height: 670,
              width:800,
            ),
            SizedBox(width: 100,),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                  const Text('Phone Number Verification',style: TextStyle(fontSize: 24)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text('Enter OTP',style
                      :TextStyle(fontSize: 25)),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      OtpInput(_fieldOne, true),
                      OtpInput(_fieldTwo, false),
                      OtpInput(_fieldThree, false),
                      OtpInput(_fieldFour, false),

                      OtpInput(_fieldFive, false),
                      OtpInput(_fieldSix, false),

                    ],
                  ), // auto focus


                  //

                  Row(
                      children:[
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _otp = _fieldOne.text +
                                    _fieldTwo.text +
                                    _fieldThree.text +
                                    _fieldFour.text+ _fieldFive.text+
                                    _fieldSix.text;
                              });
                              fetchConsents(context);
                            },
                            child: const Text('Submit')),
                        const SizedBox(
                          height: 30,
                        ),
                      ]),

                ]),
          ]),
    );

  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}