import 'dart:convert';

String accountCreationParamsToJson(AccountCreationParams data) => json.encode(data.toJson());

class AccountCreationParams {
   String? name;
   String? email;
   String? phone;
   String? gender;
   String? password;
   String? birthdate;
   String? picture;

  AccountCreationParams({
    this.name,
    this.email,
    this.phone,
    this.gender,
    this.password,
    this.birthdate,
    this.picture,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "gender": gender,
    "password": password,
    "birthdate": birthdate,
    "picture": picture,
  };
}
