import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
bool valuefirst = false;
bool valuesecond = false;
Future<void> fetchAlbum() async{
//  print("123");
  dynamic body={

    "consentId": "e8cc6822-d4bb-4eb1-9e1b-4996fbff8acb"

  };
  dynamic response = await http.post(Uri.parse('https://ks74ya816b.execute-api.ap-south-1.amazonaws.com/Dev/fi-flow/session/history'));

  print(response.body);}

//String stringResponse;


class business extends StatelessWidget {
  Future apicall()async{
    http.Response response;
    response = await http.get(Uri.parse("https:/consents/pending"));
    http.Response resp;
    resp=await http.post(Uri.parse("https:/fi-flow/session/history"));
    http.Response res;
    res = await http.delete(Uri.parse("https:/user"));

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Flutter Login Web',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width /30),
        children: [
          Menu(),
          // MediaQuery.of(context).size.width >= 980
          //     ? Menu()
          //     : SizedBox(), // Responsive
          Body()
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _menuItem(title: 'TALLY \n'
                  'SOLUTIONS'),
              _menuItem(title: 'About Tally Edge',isActive:true),
              _menuItem(title: 'About us',isActive:true),
              _menuItem(title: 'Policies',isActive:true),
              _menuItem(title: 'Help',isActive:true),
              _menuItem(title: 'Blog',isActive:true),


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
      padding: const EdgeInsets.only(right: 20),
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
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 1050,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Image.asset('illustration-1.png'),

              SizedBox(
                height: 30,
              ),
              // Text(
              //   "If you don't have an account",
              //   style: TextStyle(
              //       color: Colors.black54, fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [


                ],
              ),
              Image.asset(
                'assets/images/illustration-2.png',
                fit: BoxFit.fill,

                height: 695,
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height / 12),
          child: Container(
            width: 380,
            child: _formLogin(),
          ),
        )
      ],
    );
  }

  bool valuefirst = false;

  bool valuesecond = false;

  Widget _formLogin() {
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple,
            spreadRadius: 10,
            blurRadius: 20,
          ),
        ],
      ),
      child: ElevatedButton(
        child: Container(
            width: double.infinity,
            height: 50,
            child: Center(child: Text("SUBMIT"))),
        onPressed: () => print("it's pressed"),
        style: ElevatedButton.styleFrom(
          primary: Colors.deepPurple,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),

    );

    return Column(
      children: [
        Text('REGISTRATION',
          style: TextStyle(
              fontSize: 21),),
        SizedBox(height:30),
        Text('REGISTER AS',
          style: TextStyle(
              fontSize: 18),),
        SizedBox(height:20),

        ListTile(
          title: Row(
            children: <Widget>[
              Expanded(child: ElevatedButton(onPressed: () {},child: Text("Individual"),),),
              Expanded(child: ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>business(),
              ));},child: Text("Business"),),)

            ],
          ),
        ),
        SizedBox(height:10),
        TextField(
          decoration: InputDecoration(
            hintText: 'Your Name',

            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 25),
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
        TextField(
          decoration: InputDecoration(
            hintText: 'Mobile Number',

            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
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
        TextField(
          decoration: InputDecoration(
            hintText: 'Company Name',

            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
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
        TextField(
          decoration: InputDecoration(
            hintText: 'E-mail Id',

            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
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
        TextField(
          decoration: InputDecoration(
            hintText: 'Virtual User Address (VUA)',

            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
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
        // TextField("VUA is a unique address for your TallyEdge Account"),
        Text('VUA is a unique address for your TallyEdge Account',

          style: TextStyle(
              fontSize: 12),),
        SizedBox(height:18),

        // Text('I Agree to Terms and Conditions',
        //
        //   style: TextStyle(
        //       fontSize: 12),),
        // SizedBox(height: 40),

        Container(
            child:Row(
                children:<Widget>[
                  SizedBox(width:10,),
                  Checkbox(value: this.valuefirst, onChanged: (  value) {
                    this.valuefirst = true;

                    Text('I agree to the terms & conditions  ', style: TextStyle(fontSize: 14),);
                  }

                  ),

                  Text('I agree to the terms & conditions  ', style: TextStyle(fontSize: 14),)
                ]
            )),
        SizedBox(width:10,height:8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple,
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("SUBMIT"))),
            onPressed: () => fetchAlbum(),
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),

              ),
            ),
          ),

        ),

        SizedBox(height: 30),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            //child: Text("Or continue with"),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey[400],
              height: 50,
            ),
          ),
        ]),
        SizedBox(height: 20),


        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget> [


            Text('Already have an account? LOGIN',

              style: TextStyle(
                  fontSize: 15),),


            SizedBox(height: 30),

            //_loginWithButton(image: 'images/google.png'),
            //_loginWithButton(image: 'images/github.png', isActive: true),
            // _loginWithButton(image: 'images/facebook.png'),
          ],
        ),
      ],
    );
  }}
