import 'dart:convert';

import 'package:Vasha_Shikkha/data/controllers/login.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:Vasha_Shikkha/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationForm extends StatefulWidget {
  final scaffoldKey;

  const RegistrationForm({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final FocusNode myFocusNodeNameRegister = FocusNode();
  final FocusNode myFocusNodePhoneRegister = FocusNode();
  final FocusNode myFocusNodePasswordRegister = FocusNode();

  TextEditingController registerNameController = new TextEditingController();
  TextEditingController registerPhoneController = new TextEditingController();
  TextEditingController registerPasswordController =
      new TextEditingController();

  bool _obscureTextRegister = true;
  bool _loading = false;

  LoginController _loginController;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.antiAlias,
      children: <Widget>[
        Card(
          elevation: 2.0,
          color: Colors.white,
          margin: EdgeInsets.only(top: 20, bottom: 100, left: 20, right: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    focusNode: myFocusNodeNameRegister,
                    controller: registerNameController,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(fontSize: 17.0),
                    ),
                    validator: (val) {
                      if (val.isEmpty) return "Required field";
                      final regex = RegExp("[0-9@#\$%&]");
                      if (regex.hasMatch(val)) {
                        return "Invalid name";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    focusNode: myFocusNodePhoneRegister,
                    controller: registerPhoneController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: "Phone Number",
                      hintStyle: TextStyle(fontSize: 17.0),
                    ),
                    validator: (val) {
                      if (val.isEmpty) return "Required field";
                      final regex14 = RegExp("(?:\\+88)(01[3-9]\\d{8})");
                      final regex13 = RegExp("(?:\\88)(01[3-9]\\d{8})");
                      final regex11 = RegExp("(01[3-9]\\d{8})");
                      if ((regex11.hasMatch(val) && val.length == 11) ||
                          (regex13.hasMatch(val) && val.length == 13) ||
                          (regex14.hasMatch(val) && val.length == 14)) {
                        return null;
                      } else {
                        return 'Invalid phone number';
                      }
                    },
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
                  child: TextFormField(
                    focusNode: myFocusNodePasswordRegister,
                    controller: registerPasswordController,
                    obscureText: _obscureTextRegister,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.lock,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(fontSize: 17.0),
                      suffixIcon: GestureDetector(
                        onTap: _toggleLogin,
                        child: Icon(
                          _obscureTextRegister
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (val) {
                      if (val.isEmpty) return "Required field";
                      return val.length < 8
                          ? "Password must have at least 8 characters"
                          : null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          child: Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context).primaryColorDark,
                  offset: Offset(1.0, 6.0),
                  blurRadius: 20.0,
                ),
              ],
            ),
            child: MaterialButton(
              highlightColor: Colors.transparent,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 42.0),
                child: _loading
                    ? SizedBox(
                        width: 50,
                        child: SpinKitWanderingCubes(
                          size: 20,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _loading = true;
                  });
                  try {
                    final registerMessage = await _register();
                    showInSnackBar(registerMessage);
                    if (registerMessage.compareTo("Registration successful") ==
                        0) {
                      await _login();
                      await Future.delayed(
                        Duration(seconds: 1),
                        () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.route);
                        },
                      );
                    }
                  } catch (e) {
                    print(e);
                    showInSnackBar("Error occurred. Please try again.");
                  } finally {
                    setState(() {
                      _loading = false;
                    });
                  }
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextRegister = !_obscureTextRegister;
    });
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    widget.scaffoldKey.currentState?.removeCurrentSnackBar();
    widget.scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Future<String> _register() async {
    String _name = registerNameController.text;
    String _phone = registerPhoneController.text;
    String _password = registerPasswordController.text;
    print(_phone + " pass :" + _password + "\n-----");

    String message = await _loginController.register(_name, _phone, _password);

    return message;
  }

  Future<void> _login() {
    String _phone = registerPhoneController.text;
    String _password = registerPasswordController.text;
    print(_phone + " pass :" + _password + "\n-----");

    return _loginController.login(_phone, _password);
  }
}
