class Token{
  String _token;

  Token({
      String token
    }):_token=token;

  factory Token.fromJson(Map<String,dynamic> json){
    return new Token(
      token:json['access_token']
    );
  }
}