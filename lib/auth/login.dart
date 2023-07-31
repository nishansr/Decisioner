import 'package:decisionapp/services/functions/authFunctions.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var username = '';
  var password = '';
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(15.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    isLogin ? 'Login' : 'Register',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40),
                //! Username
                isLogin
                    ? Container()
                    : TextFormField(
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Enter username';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          username = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        key: ValueKey('username'),
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Enter your Username',
                            labelText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                      ),
                SizedBox(height: 20.0),
                //! Email
                TextFormField(
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Enter email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    email = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                      hintText: 'Enter your E-mail',
                      labelText: 'E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                ),
                SizedBox(height: 20.0),

                //! Password
                TextFormField(
                  validator: (value) {
                    if (value!.length == 0) {
                      return 'Enter password';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('password'),
                  decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        isLogin
                            ? loginUser(context, email, password)
                            : signupUser(context, email, password, username);
                        isLogin = !isLogin;
                      }
                    },
                    child: Text(
                      isLogin ? 'Login' : 'SignUp',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
