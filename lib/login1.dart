import 'package:cmutil/cmutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:try1/main.dart';
import 'package:try1/business.dart';
import 'package:try1/submit.dart';
import 'package:try1/submitlogin.dart';
import 'package:try1/mainpage.dart';
Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

TextEditingController _mobilenum = TextEditingController();
void error(FormatException err) {
  print("error" + err.toString());
}

Future fetchConsents(dynamic context) async {
  dynamic response = await Cmutil.jsonRequest(
    method: "post",
    url_path: "customer/login/otp",
    header: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    },
    body: {
      "mobile": _mobilenum.text,
    },
    error: error,
  );
  print(jsonDecode(response.body));
  print(response.statusCode);
  if (response.statusCode == 200) {
    Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => submitlogin(response.headers["set-cookie"]),
        ));

  }
  else {
    print("error");
  }
}

class loginst extends StatefulWidget {
  @override
  State<loginst> createState() => _login1State();
}

class _login1State extends State<loginst> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        // padding: EdgeInsets.symmetric(
        //     horizontal: MediaQuery.of(context).size.width /30),
        children: [
          Menu(),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body(context)
        ],
      ),);
  }
}

Widget Menu() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _menuItem(title: 'TALLY \n'
                'SOLUTIONS', isActive: true),
            _menuItem(title: 'About Tally Edge', isActive: false),
            _menuItem(title: 'About us', isActive: false),
            _menuItem(title: 'Policies', isActive: false),
            _menuItem(title: 'Help', isActive: false),
            _menuItem(title: 'Blog', isActive: false),


          ],
        ),
        Row(
          children: [
            _menuItem(title: 'Sign In', isActive: true),
            _registerButton()
          ],
        ),
      ],
    ),
  );
}

Widget _menuItem({String title = 'Title Menu', isActive = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: MouseRegion(
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
    ),
  );
}

Widget _registerButton() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 8,
          blurRadius: 12,
        ),
      ],
    ),
    child: Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
    ),
  );
}

Widget Body(dynamic context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [

      Container(
        width: 1050,
        child: Image.asset(

          'assets/images/illustration-2.png',
          fit: BoxFit.cover,

          height: 720,
        ),
      ),
      SizedBox(width: 30,),
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery
                .of(context)
                .size
                .height / 12
        ),
        child: Container(
          width: 300,
          child: _formLogin(context),
        ),
      )
    ],
  );
}

Widget _formLogin(dynamic context) {
  return Column(
    children: [
      Text('    WELCOME TO \n     TALLY EDGE',
        style: TextStyle(
            fontSize: 24),),
      SizedBox(height: 30),
      Text('    Enter your mobile number',
        style: TextStyle(
            fontSize: 18),),
      SizedBox(height: 20),

      TextField(
        controller: _mobilenum,
        decoration: InputDecoration(

          hintText: '     Mobile Number',

          filled: true,
          fillColor: Colors.blueGrey[50],
          labelStyle: TextStyle(fontSize: 12),
          contentPadding: EdgeInsets.only(left: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),

      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple,
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: ElevatedButton(
          child: Container(
            //width: double.infinity,
              height: 50,
              child: Center(child: Text("Next"))),
          onPressed: () => fetchConsents(context),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),

      ),
      SizedBox(height: 30,),
      Text("Dont have an account?"),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp(),));
        },
        child: Text("REGISTER"),
      ),

    ],
  );
}
