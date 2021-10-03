import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jio/services/auth.dart';
import 'package:jio/services/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[700],
              Colors.orange[500],
              Colors.yellow[600]
            ]
          )
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  Text("Welcome back to jio!",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ], 
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 40, 15, 70),
                    child: Form(
                      key: _formKey,
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(255, 95, 27, 0.3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )]
                              ),
                              child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                      ),
                                      child: TextFormField(
                                        onChanged: (val){
                                          setState(() => email = val);
                                        },
                                        validator: (val) => EmailValidator.validate(val) ? null : "Please input a valid email",
                                        decoration: InputDecoration(
                                          hintText: "Enter an email"
                                        )
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                      ),
                                      child: TextFormField(
                                        onChanged: (val){
                                          setState(() => password = val);
                                        },
                                        validator: (val) => val.length < 6 ? "Please input a valid password" : null,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: "Enter a password"
                                        )
                                      ),
                                    ),
                                  ]
                                ),
                            ),
                            SizedBox(height: 20),
                            FlatButton(
                            onPressed: (){
                              //TO DO
                            },
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.grey),),
                            ),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.orange[600]
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: FlatButton(
                                  onPressed: () async{
                                    if (_formKey.currentState.validate() == true){
                                        setState(() => loading = true);
                                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                        if (result == null){
                                          setState(() {
                                          error = 'Failed to sign in!';
                                          loading = false;
                                          });
                                        }
                                      }
                                    },
                                  child: Text("Login",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)
                                    ),
                                  ),
                                )
                              )
                            ),
                            SizedBox(height: 30),
                            Container(
                              child: Text("Don't have an account yet?",
                              style: TextStyle(color: Colors.grey[700]),),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green[600]
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: FlatButton(
                                  onPressed: (){
                                    widget.toggleView();
                                  }, //SIGN UP BUTTON
                                  child: Text("Sign up",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)
                                    ),
                                  ),
                                )
                              )
                            ),
                          ],
                        ),
                    ),
                  )
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}