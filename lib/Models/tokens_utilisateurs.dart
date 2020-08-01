class Tokens {
 String token;
  Tokens({this.token,  });

  Tokens.fromMap(Map<String, dynamic> donnees,)
      : token = donnees["token"];
       


  Map<String, dynamic> toMap() {
    return {
      "token": token,
    
    };
  }
}