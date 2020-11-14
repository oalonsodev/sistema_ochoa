import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
	ProductModel({
		this.id,
		this.linea,
		this.nombre,
		this.noParte,
		this.marca,
		this.modelo,
		this.cantidad,
		this.unidad,
		this.comentario,
		this.moneda,
		this.precio,
	});

	String id;
	int linea;
	String nombre;
	int noParte;
	String marca;
	String modelo;
	int cantidad;
	String unidad;
	String comentario;
	String moneda;
	double precio;

	factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
		id	        : json["id"],
		linea				: json["linea"],
		nombre			: json["nombre"],
		noParte			: json["noParte"],
		marca				: json["marca"],
		modelo			: json["modelo"],
		cantidad		: json["cantidad"],
		unidad			: json["unidad"],
		comentario	: json["comentario"],
		moneda			: json["moneda"],
		precio			: json["precio"].toDouble(),
	);

	Map<String, dynamic> toJson() => {
		"id"	        : id,
		"linea"				: linea,
		"nombre"			: nombre,
		"noParte"			: noParte,
		"marca"				: marca,
		"modelo"			: modelo,
		"cantidad"		: cantidad,
		"unidad"			: unidad,
		"comentario"	: comentario,
		"moneda"			: moneda,
		"precio"			: precio,
	};
}