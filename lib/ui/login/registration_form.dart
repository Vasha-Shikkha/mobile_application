import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Vasha_Shikkha/utils/rest_api.dart';

class RegistrationForm extends StatefulWidget {
  final scaffoldKey;

  const RegistrationForm({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final FocusNode myFocusNodePhoneLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginPhoneController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

  final String _dummyPhone = "01712345678";
  final String _dummyPassword = "test1234";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 100, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.5,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.antiAlias,
        children: <Widget>[
          Card(
            elevation: 2.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                  child: TextField(
                    focusNode: myFocusNodePhoneLogin,
                    controller: loginPhoneController,
                    keyboardType: TextInputType.phone,
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
                  child: TextField(
                    focusNode: myFocusNodePhoneLogin,
                    controller: loginPhoneController,
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
                  child: TextField(
                    focusNode: myFocusNodePasswordLogin,
                    controller: loginPasswordController,
                    obscureText: _obscureTextLogin,
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
                          _obscureTextLogin
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
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
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                onPressed: () {
                  if (loginPhoneController.text == _dummyPhone &&
                      loginPasswordController.text == _dummyPassword) {
                    showInSnackBar("Login complete");
                    _login();
                    Navigator.of(context).pushReplacementNamed('/mcq');
                  } else {
                    showInSnackBar("Incorrect phone number or password");
                  }

                  //No need to show this now
                  //TODO: Need progressbar for API calls
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => MyHomePage())
                  // );
                  // Navigator.of(context).pushReplacement(
                  //   new MaterialPageRoute(builder: (context) =>AnimationDemoHome()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
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

  void _login() async {
    String _phone = loginPhoneController.text;
    String _password = loginPasswordController.text;
    print(_phone + " pass :" + _password + "\n-----");

    final tokenEntry = await RestApi().login(_phone, _password);
  }
}
