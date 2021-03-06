import 'package:deezer/Screens/Home/home.dart';
import 'package:deezer/Services/auth.dart';
import 'package:deezer/Shared/loading.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String message = "";

  bool _isHidden = true;
  bool loading = false;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 23.0),
                ),
                SizedBox(
                  height: 45.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 2.0, bottom: 2.0),
                      color: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "f",
                            style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    OutlineButton(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 17.0, top: 3.0, bottom: 3.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      highlightedBorderColor: Colors.white70,
                      highlightColor: Colors.black12,
                      highlightElevation: 2.0,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage("lib/images/google.png"),
                            width: 36.0,
                            height: 36.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Google",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "or",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: (val) => val.isEmpty ? "Enter an email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  cursorColor: Colors.black45,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(
                    labelText: "Email",
                    contentPadding: EdgeInsets.only(bottom: 0.0, top: 0.0),
                    labelStyle: TextStyle(color: Colors.black45),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  validator: (val) => val.isEmpty
                      ? "Password must be at least 6 characters"
                      : null,
                  onChanged: (val) => setState(() => password = val),
                  obscureText: _obscureText,
                  cursorColor: Colors.black45,
                  style: TextStyle(fontSize: 18.0),
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Password",
                    contentPadding: EdgeInsets.only(bottom: 0.0, top: 0.0),
                    labelStyle: TextStyle(color: Colors.black45),
                    suffixIcon: GestureDetector(
                      onTap: (){
                        setState(() {
                          _isHidden = !_isHidden;
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 35.0),
                FlatButton( 
                  padding:
                      EdgeInsets.symmetric(horizontal: 57.0, vertical: 16.0),
                  color: Colors.pinkAccent.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () async {
                    setState(() => loading = true);
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null){
                        setState((){
                          message = "Invalid Email/Password";
                          loading = false;
                        });
                      }else{
                        Navigator.of(context).pop();
                        print("Login Successful.");
                        print(result.uid);
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Forgot your password?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black45),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
