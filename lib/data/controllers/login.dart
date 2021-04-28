
import '../models/token.dart';
import '../rest/login.dart'; // just for testing
import '../db/token.dart';

class LoginController{
  
  LoginRest loginRest = new LoginRest();
  
  TokenDatabaseHelper tokenDatabaseHelper = new TokenDatabaseHelper();

  Future<void>_insertToken(Token token)
  {
    tokenDatabaseHelper.insertToken(token.toDatabase());
  }

  Future<void>_deleteToken()
  {
    tokenDatabaseHelper.deleteToken();
  }

  Future<Token>login(String phone,String password)async{
    int count= await tokenDatabaseHelper.getCount();
    //need to check if token has expired
    Token token;
    
    if(count == 0)//or if token has expired
    {
      token=await loginRest.login(phone, password);
      _insertToken(token);
    }

    token=await tokenDatabaseHelper.getToken();
    return token;
  }

  Future<void>register()async{
    //Later
  }



  
}