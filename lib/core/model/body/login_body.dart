// ignore_for_file: unnecessary_this

class LoginBody {
  String? email;
  String? password;

  LoginBody({this.email, this.password});

  // LoginBody.fromJson(json) {
  //   this.email = json["email"];
  // }

  toJson() => {
        'email': this.email,
        'password': this.password,
      };
}
