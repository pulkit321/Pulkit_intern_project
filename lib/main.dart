import 'package:flutter/material.dart';
import 'mainpage.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:try1/business.dart';
import 'package:try1/login1.dart';
import 'package:try1/submit.dart';
import 'package:try1/Raildest.dart';
import 'package:cmutil/cmutil.dart';
import 'dart:io';
import 'package:rxdart/rxdart.dart';

bool valuefirst = false;
bool valuesecond = false;
Future<void> fetchAlbum() async{
//  print("123");
  dynamic body={

    "sessionId": "ebbc816f-f391-4a7b-a477-f204d0236544",
    "fiSubSessionsHistory": [
      {
        "maskedAccountNumber": "XXXXXXX2340",
        "linkReferenceNumber": "87550594080",
        "accountType": "SAVINGS",
        "fipName": "Mera FIP",
        "flowStatesDetails": {
          "requestSentStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:05:30.611Z"
          },
          "dataFetchedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:10:17.111Z"
          },
          "notifiedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:13:30.735Z"
          },
          "dataDeliveredStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:16:25.635Z"
          }
        }
      },
      {
        "maskedAccountNumber": "XXXXXXX7444",
        "linkReferenceNumber": "94730538022",
        "accountType": "SAVINGS",
        "fipName": "Mera FIP",
        "flowStatesDetails": {
          "requestSentStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:05:30.611Z"
          },
          "dataFetchedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:10:17.111Z"
          },
          "notifiedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:13:30.735Z"
          },
          "dataDeliveredStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:16:25.635Z"
          }
        }
      },
      {
        "maskedAccountNumber": "XXXXXXX8548",
        "linkReferenceNumber": "59294540167",
        "accountType": "SAVINGS",
        "fipName": "Mera Doosra FIP",
        "flowStatesDetails": {
          "requestSentStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:05:30.611Z"
          },
          "dataFetchedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:13:28.701Z"
          },
          "notifiedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:13:30.735Z"
          },
          "dataDeliveredStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:17:01.807Z"
          }
        }
      },
      {
        "maskedAccountNumber": "XXXXXXX1488",
        "linkReferenceNumber": "67570058235",
        "accountType": "SAVINGS",
        "fipName": "Mera Doosra FIP",
        "flowStatesDetails": {
          "requestSentStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:05:30.611Z"
          },
          "dataFetchedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:13:28.701Z"
          },
          "notifiedStateDetails": {
            "status": "COMPLETED",
            "timestamp": "2023-01-04T06:13:30.735Z"
          },
          "dataDeliveredStateDetails": {
            "status": "FAILED",
            "timestamp": "2023-01-04T06:17:20.690Z"
          }
        }
      }
    ]


  };
  dynamic response = await http.post(Uri.parse('https://ks74ya816b.execute-api.ap-south-1.amazonaws.com/Dev/fi-flow/sub-session/history'),body:body);

  print(response.body);}


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future apicall()async{
    http.Response response;

  }
  bool _isloading =  true;
  @override
  void initState() {
    Config.init();
    setState(() {
      _isloading=false;
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return (_isloading)?MaterialApp(
      home: Center(child: CircularProgressIndicator(),),
    ):MaterialApp(
        title: 'ChitMit',
        initialRoute:'/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => StreamBuilder<String>(
            stream: AuthSrv.onAuthChange,
            builder: (context, snapshot) {
              print("SnapshotData"+snapshot.data.toString());
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot?.data==null ) {
                return CircularProgressIndicator();
              }
              else if (snapshot.connectionState == ConnectionState.active
                  || snapshot.connectionState == ConnectionState.done ) {
                if (snapshot.hasError) {
                  // Handle error
                  print('Error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                }
                // Render data
                else if (snapshot.hasData) {
                  print("inside elseif");
                  print(snapshot.data);
                  if(snapshot.data == ""){ return LoginPage();}
                  else{
                    print("else");
                    print(AuthSrv.authToken);
                    // return MainnPage();
                  }
                }
                else{
                  print("inside else");
                  print(snapshot.data);
                }
              }
              return CircularProgressIndicator();
            },
          ),
          //  '/home': (BuildContext context) => MainnPage(),
          '/login': (BuildContext context) => LoginPage(),

        });
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          Body()
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Image.asset("assets/images/img.png",scale: 0.9),
              _menuItem(title: 'About Tally Edge',isActive:true),
              _menuItem(title: 'About us',isActive:true),
              _menuItem(title: 'Policies',isActive:true),
              _menuItem(title: 'Help',isActive:true),
              _menuItem(title: 'Blog',isActive:true),
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
            color: Colors.white30,
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


  TextEditingController _email=TextEditingController();
  TextEditingController _name=TextEditingController();
  TextEditingController _mobilenum=TextEditingController();
  TextEditingController _vua=TextEditingController();
  void error(FormatException err)
  {
    print("error"+err.toString());
    //print(err.toString());
  }

  Future signUp() async{
    dynamic response = await Cmutil.jsonRequest(
      method: "post",
      url_path: "register/individual/otp",
      header: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        //"session-id" : ""
      },
      body:{


        // "name": _nameController.text,
        "countryCode": "+91",
        "email":_email.text,
        "force":true,
        "mobile": _mobilenum.text,
        "name":_name.text,
        "tnc":true,
        "vua":_vua.text,
      },
      error: error,
    );

    // print(jsonDecode(response.body));
    // print("Headers    ${response.headers}");
    // print(response.statusCode);
    // if(response["token"]!=null) {
    //   String authToken = response["token"];
    //   print("value of authToken is : " + authToken);
    //   await Cmutil.setAuth(authToken);
    //   print(AuthSrv.authToken);
    // }
    if( response.statusCode ==200  ){
      Navigator.of(context).push(

          MaterialPageRoute(
            builder: (context) => submit(response.headers["set-cookie"]),
          ));
    }
    else{print("error");}

    //pass the email and password through this
  }

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

              SizedBox(
                height: 10,
              ),
              Column(
                children: [


                ],
              ),
              Image.asset(
                'assets/images/illustration-2.png',
                fit: BoxFit.fill,

                height: 695,
              ),
              //_loginWithButton(image: 'images/google.png'),
              //_loginWithButton(image: 'images/github.png', isActive: true),
              // _loginWithButton(image: 'images/facebook.png'),
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

        ),
        //  _loginWithButton(image:'assets/images/illustration-1.png'),
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
            color: Colors.deepPurpleAccent,
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
        onPressed: () {
          // signUp();
          signUp();
        },
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
          controller: _name,
          decoration: InputDecoration(
            hintText: 'Your Name',

            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 25),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(
          height: 30,

        ),

        TextField(
          controller: _mobilenum,
          decoration: InputDecoration(
            hintText: 'Mobile Number',

            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          controller: _email,
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
          controller: _vua,
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

        Text('VUA is a unique address for your TallyEdge Account',

          style: TextStyle(
              fontSize: 12),),
        SizedBox(height:18),
        Container(
            child:Row(
                children:<Widget>[
                  SizedBox(width:10,),
                  Checkbox(value: this.valuefirst, onChanged: (value) {
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
            // child: Center(child:ElevatedButton(onPressed: ()
            // {Navigator.push(context ,MaterialPageRoute(builder: (context)=>submit(),));},child:Text("SUBMIT")))),
            onPressed: () => signUp(),
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
        SizedBox(height: 15),


        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [


            Text('Already have an account?',

              style: TextStyle(
                  fontSize: 15),),

            // Expanded(child: ElevatedButton(onPressed: () {},child: Text("Login"),),),
            Expanded(child: ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> loginst(),
            ));},child: Text("LOGIN"),),),

          ],
        ),
      ],
    );
  }}
class ButtonPressed extends StatefulWidget {
  @override
  _ButtonPressedState createState() => _ButtonPressedState();

}

class _ButtonPressedState extends State<ButtonPressed> {
  @override
  Widget build(BuildContext context) {
    print ('inside button press');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Screen 3'),
      ),
      // create a popup to show some msg.
    );
  }
}
Widget _loginWithButton({String? image, bool isActive = false}) {
  return Container(
    width: 90,
    height: 70,
    decoration: isActive
        ? BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: 10,
          blurRadius: 30,
        )
      ],
      borderRadius: BorderRadius.circular(15),
    )
        : BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey),
    ),
    child: Center(
        child: Container(
          decoration: isActive
              ? BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 15,
              )
            ],
          )
              : BoxDecoration(),
          child: Image.asset(
            '$image',
            width: 35,
          ),
        )),
  );
}
