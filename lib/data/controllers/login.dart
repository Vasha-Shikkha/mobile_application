
import '../models/token.dart';
import '../rest/login.dart'; // just for testing
import '../db/token.dart';

class LoginController{
  
  LoginRest loginRest = new LoginRest();
  
  TokenDatabaseHelper tokenDatabaseHelper = new TokenDatabaseHelper();

  Future<void>_insertToken(Token token)async
  {
    await tokenDatabaseHelper.insertToken(token.toDatabase());
  }

  Future<void>_deleteToken()async
  {
    await tokenDatabaseHelper.deleteToken();
  }



  Future<Token>login(String phone,String password)async{
    int count= await tokenDatabaseHelper.getCount();
    //need to check if token has expired
    Token token;
    
    if(count == 0)//or if token has expired
    {
      token=await loginRest.login(phone, password);
      await _insertToken(token);
    }

    token=await tokenDatabaseHelper.getToken();
    return token;
  }

  Future<String>register(String username,String phoneNumber,String password)async{
    String registerMessage = await loginRest.register(username, phoneNumber, password);
    return registerMessage;
  }



  
}