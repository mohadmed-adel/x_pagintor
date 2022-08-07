import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  final int? id;
  final String? name;

  final String? price;

  final String? image;
  final String? description;
  const Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'] == null ? "" : json["image"],
      description: json['description'] == null ? "" : json["description"],
      price: json['price'],
    );
  }
}

class PagModal {
  List? datat;
  int? statusCode;
  String? errorMessage;
  String? next_page_url;
  int? total;
  int? nItems;

  PagModal.fromResponse(http.Response response) {
    statusCode = response.statusCode;

    total = json.decode(response.body)['total'];

    datat = json
        .decode(response.body)["data"]
        .map((e) => Product.fromJson(e))
        .toList();

    nItems = datat!.length;
  }
  PagModal.fromJson(Map<String, dynamic> response, int code) {
    statusCode = code;

    total = response['total'];
    next_page_url = response["next_page_url"];

    datat = response["data"].map((e) => Product.fromJson(e)).toList();

    nItems = datat!.length;
  }
  PagModal.withError(this.errorMessage);
}
