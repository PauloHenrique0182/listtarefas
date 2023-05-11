import 'dart:convert';

class LoginModel {
  String nome;
  String senha;

  LoginModel({
    required this.nome,
    required this.senha,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        nome: json["nome"],
        senha: json["senha"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "senha": senha,
      };
}

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());
