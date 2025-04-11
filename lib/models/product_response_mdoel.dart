// To parse this JSON data, do
//
//     final productResponseModel = productResponseModelFromJson(jsonString);

import 'dart:convert';

ProductResponseModel productResponseModelFromJson(String str) => ProductResponseModel.fromJson(json.decode(str));

String productResponseModelToJson(ProductResponseModel data) => json.encode(data.toJson());

class ProductResponseModel {
  final String? response;
  final List<ProductDetail>? productDetails;

  ProductResponseModel({
    this.response,
    this.productDetails,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) => ProductResponseModel(
    response: json["response"],
    productDetails: json["product_details"] == null ? [] : List<ProductDetail>.from(json["product_details"]!.map((x) => ProductDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "product_details": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
  };
}

class ProductDetail {
  final int? id;
  final String? productname;
  final int? offerprice;
  final String? imageurl;
  final int? price;
  final Status? status;
  final CategoryName? categoryName;
  final dynamic rating;
  final Iswishlist? iswishlist;

  ProductDetail({
    this.id,
    this.productname,
    this.offerprice,
    this.imageurl,
    this.price,
    this.status,
    this.categoryName,
    this.rating,
    this.iswishlist,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    id: json["id"],
    productname: json["productname"],
    offerprice: json["offerprice"],
    imageurl: json["imageurl"],
    price: json["price"],
    status: statusValues.map[json["status"]]!,
    categoryName: categoryNameValues.map[json["categoryName"]]!,
    rating: json["rating"],
    iswishlist: iswishlistValues.map[json["iswishlist"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productname": productname,
    "offerprice": offerprice,
    "imageurl": imageurl,
    "price": price,
    "status": statusValues.reverse[status],
    "categoryName": categoryNameValues.reverse[categoryName],
    "rating": rating,
    "iswishlist": iswishlistValues.reverse[iswishlist],
  };
}

enum CategoryName {
  CAKE,
  MINI_CAKES
}

final categoryNameValues = EnumValues({
  "cake": CategoryName.CAKE,
  "Mini Cakes": CategoryName.MINI_CAKES
});

enum Iswishlist {
  FALSE,
  TRUE
}

final iswishlistValues = EnumValues({
  "False": Iswishlist.FALSE,
  "True": Iswishlist.TRUE
});

enum Status {
  ACTIVE
}

final statusValues = EnumValues({
  "Active": Status.ACTIVE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
