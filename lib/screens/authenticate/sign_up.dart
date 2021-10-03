import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:jio/services/auth.dart';
import 'package:jio/services/loading.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({ this.toggleView });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  //text field state
  String email = "";
  String name = "";
  String password = "";
  String password2 = "";
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
                    Text("Sign Up",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    Text("Start to jio your friends!",
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
                      padding: EdgeInsets.fromLTRB(15, 40, 15, 20),
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
                                            setState(() => name = val);
                                          },
                                          validator: (val) => val!=null ? null : "Please input a name",
                                          decoration: InputDecoration(
                                            hintText: "Profile Name"
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
                                          validator: (val) => val.length < 6 ? "Enter a password 6+ chars long" : null,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "Enter a password"
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
                                            setState(() => password2 = val);
                                          },
                                          validator: (val) {
                                            if (val != password) {
                                              return "Passwords don't match!";
                                            }
                                            else {
                                              return null;
                                            }
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "Confirm Password"
                                          )
                                        ),
                                    ),
                                  ]
                                )
                              ),
                            SizedBox(height: 30),
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
                                  onPressed: () async {
                                    if(_formKey.currentState.validate()){
                                      
                                      setState(() => loading = true);
                                      
                                      //Sign up and login 
                                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                                      
                                      if(result == null) {
                                        setState(() {
                                          loading = false;
                                          error = 'Please supply a valid email';
                                        });
                                      }
                                    }
                                  },
                                  child: Text("Sign up",
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)
                                    ),
                                  ),
                                )
                              )
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                            child: SizedBox(
                                  width: double.infinity,
                                  child: FlatButton(
                                  onPressed: () {
                                    widget.toggleView();
                                   },
                                  child: Text("Have an account?",
                                  style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold,)
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      )
                    )
                  ),
                ),
              )
            ]
          ),
        ),
    );
  }
}