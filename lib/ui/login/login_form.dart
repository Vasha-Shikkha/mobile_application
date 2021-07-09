//import 'package:Vasha_Shikkha/data/moor_database.dart';
//import 'package:Vasha_Shikkha/data/rest/login.dart';
// import 'package:Vasha_Shikkha/data/controllers/fb.dart';
// import 'package:Vasha_Shikkha/data/controllers/js.dart';
// import 'package:Vasha_Shikkha/data/controllers/mcq.dart';
import 'package:Vasha_Shikkha/data/controllers/fb.dart';
import 'package:Vasha_Shikkha/data/controllers/js.dart';
import 'package:Vasha_Shikkha/data/controllers/mcq.dart';
import 'package:Vasha_Shikkha/data/controllers/topic.dart';
import 'package:Vasha_Shikkha/data/models/dict.dart';
import 'package:Vasha_Shikkha/data/models/fb.dart';
import 'package:Vasha_Shikkha/data/models/js.dart';
import 'package:Vasha_Shikkha/data/models/mcq.dart';
import 'package:Vasha_Shikkha/data/models/token.dart';
import 'package:Vasha_Shikkha/data/models/topic.dart';

import 'package:Vasha_Shikkha/style/colors.dart';
import 'package:Vasha_Shikkha/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/controllers/login.dart';

import '../../data/models/error.dart';
import '../../data/models/sm.dart';
import '../../data/controllers/error.dart';

import '../../data/models/topic.dart';
import '../../data/controllers/topic.dart';
import '../../data/controllers/fb.dart';
import '../../data/controllers/js.dart';
import '../../data/models/pw.dart';
import '../../data/models/task.dart';

import '../../data/rest/task.dart';

import '../../data/controllers/topic.dart';
import '../../data/controllers/task.dart';

import '../../data/controllers/dict.dart';
import '../../data/rest/dict.dart';

import 'dart:async';


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
  bool _loading = false;

  LoginController _loginController;
  final String _dummyPhone = "01730029348";
  final String _dummyPassword = "123";

  @override
  void initState() {
    super.initState();
    _loginController = LoginController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.antiAlias,
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
                  minWidth: MediaQuery.of(context).size.width / 2,
                  height: 30,
                  highlightColor: Colors.transparent,
                  splashColor: CustomColors.loginGradientEnd,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: _loading
                      ? SizedBox(
                          width: 50,
                          child: SpinKitWanderingCubes(
                            size: 20,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    try {
                      await _login();
                      showInSnackBar("Login successful");
                      await Future.delayed(
                        Duration(seconds: 1),
                        () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.id);
                        },
                      );
                    } catch (e) {
                      print(e);
                      showInSnackBar("Incorrect phone number or password");
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 15.0,
                ),
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
      backgroundColor: Theme.of(context).primaryColorDark,
      duration: Duration(seconds: 1),
    ));
  }

  Future<void> _login() async {
  
    String _phone = loginPhoneController.text;
    String _password = loginPasswordController.text;
    print(_phone + " pass :" + _password + "\n-----");

    String message= await _loginController.register("Blaziken", "01923441121", "1221");
    print(message);


    Token tokenEntry = await _loginController.login(_phone, _password);

    // DictController dictController= new DictController();

    //Dictionary dict = await DictRest().getDictionary(tokenEntry.token);    

    // await dictController.downloadDictionary(tokenEntry.token);

    // List<String>words=await dictController.getWordList();


    // DictEntry a= await dictController.getDictEntry('aback');
    // DictEntry b= await dictController.getDictEntry('abandoned');
    // DictEntry c= await dictController.getDictEntry('abashed');

    // List<DictEntry>flashCards= await dictController.getFlashCards();

    // for(DictEntry card in flashCards)
    //   print(card.word);

    // DictEntry d= await dictController.getDictEntry('abandoned');
    
    // flashCards= await dictController.getFlashCards();

    // for(DictEntry card in flashCards)
    //   print(card.word);

    // print(words.length);
    
    // for(int i=0;i<3;i++)
    //   dict.list[i].debugMessage();
    // for(int i)

    TopicController topicController = new TopicController();
    
    List<Topic>getTopicList = await topicController.getTopicList(tokenEntry.token, 'grammar', 1);

    TaskController taskController= new TaskController();

    List<TaskList> list = await taskController.getTaskList(tokenEntry.token, 20, 2, 10, 0);

    if(list[0].taskName == 'Sentence Matching')
    {
      SMList smList = new SMList(smList: list[0].taskList);
      Map<String,dynamic>m=smList.getParts(smList.smList);
      print(m);
    }
    
    for(TopicTask element in list[0].taskList)
    {
      if(element.taskName == 'Picture to Word')
      { 
        print("We are in touching distance");
        PW temp=element;
        temp.debugMessage();
        
      }
      // else if(element.taskName == 'Sentence Matching')
      // {
      //   print("We are the champions, my friends");
      //   SM temp=element;
      //   temp.debugMessage();
      // }
      else if(element.taskName == 'Jumbled Sentence')
      {
        print("Hello mister");
        JS temp=element;
        temp.debugMessage();
      }
      else if(element.taskName == 'Fill in the Blanks')
      {
        print("Hibana");
        FB temp=element;
        temp.debugMessage();
      }
      else if(element.taskName == 'MCQ')
      {
        print("Hehehe");
        MCQ temp=element;
        temp.debugMessage();
      }
      else if(element.taskName == 'Error in Sentence')
      {
        print("Hehehe");
        Error temp=element;
        temp.debugMessage();
      }
      
    }

    // LoginController loginController = new LoginController();
    // TopicController topicController = new TopicController();

    // FBController fbController = new FBController();
    // JSController jsController = new JSController();
    // MCQController mcqController = new MCQController();

    // ErrorController errorController = new ErrorController();

    //print(tokenEntry.token);
    // print(tokenEntry.token);
    // print(tokenEntry.token);
    // print("Hello");

    // List<Topic> topicList =
    //     await topicController.getTopicList(tokenEntry.token, 'grammar', 4);

    // for (Topic topic in topicList) {
    //   topic.debugMessage();
    // }

    /*
    FBList fbList = await FBRest().getFBList(tokenEntry.token,6,4,5,0);
    fbList.fbs[0].debugMessage();
    */

    // List<FB> fbList2 =
    //     await fbController.getFBList(tokenEntry.token, 6, 4, 5, 0);
    // fbList2[0].debugMessage();

    /*
    JSList jsList=await JSRest().getJSList(tokenEntry.token, 24, 3, 20, 0);
    print("Hello World");
    jsList.jsList[0].debugMessage();
    */

    // List<JS> jsList2 =
    //     await jsController.getJSList(tokenEntry.token, 24, 3, 20, 0);
    // jsList2[0].debugMessage();

    // List<MCQ> mcqList2 =
    //     await mcqController.getMCQList(tokenEntry.token, 4, 4, 20, 0);
    // print(mcqList2.length);
    // mcqList2[0].debugMessage();

    // List<Error> errorList2 =
    //     await errorController.getErrorList(tokenEntry.token, 25, 6, 20, 0);
    // print(errorList2.length);
    // errorList2[0].debugMessage();

    //final tokenEntry = await RestApi().login(_phone, _password);
    //_dbProvider.addToken(token: tokenEntry['token']);
  }
}
