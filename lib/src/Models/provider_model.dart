import 'dart:convert';

ProviderModel providerModelFromJson(String str) =>
    ProviderModel.fromJson(json.decode(str));

String providerModelToJson(ProviderModel data) => json.encode(data.toJson());

class ProviderModel {
  ProviderModel({this.nombre, this.correo, this.contacto, this.numeroTel});

  String nombre;
  String correo;
  String contacto;
  int numeroTel;

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
      nombre: json["nombre"],
      correo: json["correo"],
      contacto: json["contacto"],
      numeroTel: json["numeroTel"]);

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "correo": correo,
        "contacto": contacto,
        "numeroTel": numeroTel
      };
}
