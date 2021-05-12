//import 'package:Vasha_Shikkha/data/moor_database.dart';
//import 'package:Vasha_Shikkha/data/rest/login.dart';
import 'package:Vasha_Shikkha/data/controllers/mcq.dart';
import 'package:Vasha_Shikkha/style/colors.dart';
//import 'package:Vasha_Shikkha/utils/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../data/rest/fb.dart';
import '../../data/models/fb.dart';


import '../../data/rest/js.dart';
import '../../data/models/js.dart';

import '../../data/rest/mcq.dart';
import '../../data/models/mcq.dart';

import '../../data/models/token.dart';
import '../../data/controllers/login.dart';

import '../../data/models/topic.dart';
import '../../data/controllers/topic.dart';
import '../../data/controllers/fb.dart';
import '../../data/controllers/js.dart';

class LoginForm extends StatefulWidget {
  final scaffoldKey;

  const LoginForm({Key key, this.scaffoldKey}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode myFocusNodePhoneLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginPhoneController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  //TokensDao _dbProvider;
  final String _dummyPhone = "01730029348";
  final String _dummyPassword = "123";

  @override
  void initState() {
    super.initState();
    //_dbProvider = Provider.of<TokensDao>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
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
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomColors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomColors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                    colors: [
                      CustomColors.loginGradientEnd,
                      CustomColors.loginGradientStart,
                    ],
                    begin: const FractionalOffset(0.2, 0.2),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomColors.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "LOGIN",
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
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: () => showInSnackBar("Facebook button pressed"),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.facebookF,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => showInSnackBar("Google button pressed"),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      FontAwesomeIcons.google,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
            ],
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

    LoginController loginController=new LoginController();
    TopicController topicController=new TopicController();

    FBController fbController=new FBController();
    JSController jsController=new JSController();
    MCQController mcqController=new MCQController();
    
    Token tokenEntry = await loginController.login(_phone, _password);
    //print(tokenEntry.token);
    print(tokenEntry.token);
    print("Hello");

    
    List<Topic> topicList=await topicController.getTopicList(tokenEntry.token, 'grammar', 4);
    
    for(Topic topic in topicList)
    {
      topic.debugMessage();
    }
    
    /*
    FBList fbList = await FBRest().getFBList(tokenEntry.token,6,4,5,0);
    fbList.fbs[0].debugMessage();
    */
    
    //List<FB>fbList2= await fbController.getFBList(tokenEntry.token, 6, 4, 5, 0);
    //fbList2[0].debugMessage();
    
    /*
    JSList jsList=await JSRest().getJSList(tokenEntry.token, 24, 3, 20, 0);
    print("Hello World");
    jsList.jsList[0].debugMessage();
    */
    
    //List<JS> jsList2=await jsController.getJSList(tokenEntry.token, 24, 3, 20, 0);
    //jsList2[0].debugMessage();
    List<MCQ> mcqList2= await mcqController.getMCQList(tokenEntry.token, 4, 4, 20, 0);
    print(mcqList2.length);
    mcqList2[0].debugMessage();
    //final tokenEntry = await RestApi().login(_phone, _password);
    //_dbProvider.addToken(token: tokenEntry['token']);
  }
}
