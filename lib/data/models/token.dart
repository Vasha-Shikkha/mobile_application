class Token{
  
  String _token;
  String _tokenType;
  String _expiryDate;
 
  String get token => this._token;

  set token(String value) => this._token = value;

  get tokenType => this._tokenType;

  set tokenType( value) => this._tokenType = value;

  get expiryDate => this._expiryDate;

  set expiryDate( value) => this._expiryDate = value;

  Token({
      String token,
      String tokenType,
      String expiryDate
    }):_token=token,
      _tokenType=tokenType,
      _expiryDate=expiryDate;

  factory Token.fromJson(Map<String,dynamic> json){
    return new Token(
      token:json['access_token'],
      tokenType:json['type'],
      expiryDate:json['expires_at']
    );
  }

  factory Token.fromDatabase(Map<String,dynamic>map){
    return new Token(
      token:map['Token'],
      tokenType:map['Type'],
      expiryDate:map['ExpiryDate']
    );
  }

  Map<String,dynamic>toDatabase()
  {
    Map<String,dynamic>result=new Map();
    result['Token']=token;
    result['Type']=tokenType;
    result['ExpiryDate']=expiryDate;

    return result;
  }
}