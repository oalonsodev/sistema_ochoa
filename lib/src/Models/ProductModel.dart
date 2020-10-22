import 'dart:convert';
import 'package:intl/intl.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
	ProductModel({
		this.id,
		this.fecha,
		this.folio,
		this.noReq,
		this.cliente,
		this.direccion,
		this.comprador,
		this.departamento,
		this.condicionesVenta,
		this.tiempoEntrega,
	}){

    fecha = DateFormat('dd/MM/yyyy').format(DateTime.now());
  
  }

	String id;
  String fecha;
	String folio;
	int noReq;
	String cliente;
	String direccion;
	String comprador;
	String departamento;
	String condicionesVenta;
	String tiempoEntrega;

	factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
		id								: json["id"],
		fecha							: json["fecha"],
		folio							: json["folio"],
		noReq							: json["noReq"],
		cliente						: json["cliente"],
		direccion					: json["direccion"],
		comprador					: json["comprador"],
		departamento			: json["departamento"],
		condicionesVenta	: json["condicionesVenta"],
		tiempoEntrega			: json["tiempoEntrega"],
	);

	Map<String, dynamic> toJson() => {
		"id"								: id,
		"fecha"							: fecha,
		"folio"							: folio,
		"noReq"						: noReq,
		"cliente"						: cliente,
		"direccion"					: direccion,
		"comprador"					: comprador,
		"departamento"			: departamento,
		"condicionesVenta"	: condicionesVenta,
		"tiempoEntrega"		: tiempoEntrega,
	};
}