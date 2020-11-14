import 'dart:convert';
import 'package:intl/intl.dart';

QuotationModel quotationModelFromJson(String str) => QuotationModel.fromJson(json.decode(str));

String quotationModelToJson(QuotationModel data) => json.encode(data.toJson());

class QuotationModel {
	QuotationModel({
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
		this.productos
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
	List<String> productos;

	factory QuotationModel.fromJson(Map<String, dynamic> json) => QuotationModel(
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
		productos         : json["productos"]
	);

	Map<String, dynamic> toJson() => {
		"id"								: id,
		"fecha"							: fecha,
		"folio"							: folio,
		"noReq"						  : noReq,
		"cliente"						: cliente,
		"direccion"					: direccion,
		"comprador"					: comprador,
		"departamento"			: departamento,
		"condicionesVenta"	: condicionesVenta,
		"tiempoEntrega"		  : tiempoEntrega,
		"productos"					: productos
	};
}