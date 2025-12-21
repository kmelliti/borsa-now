import 'package:json_annotation/json_annotation.dart';


class ProductModel {
  final int id;
  final int merchantId;
  final int productCategorieId;
  final String sku;
  final String name;
  final String description;
  final double costBasis;
  final bool isDeleted;

  final String createdBy;
  final String updatedBy;
  final String deletedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductPicture> productPictures;

  ProductModel({
    required this.id,
    required this.merchantId,
    required this.productCategorieId,
    required this.sku,
    required this.name,
    required this.description,
    required this.costBasis,
    required this.isDeleted,
    required this.createdBy,
    required this.updatedBy,
    required this.deletedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.productPictures,
  });


}

ProductModel mockProductModel() {
  return ProductModel(
    id: 1,
    merchantId: 1,
    productCategorieId: 1,
    sku: "SKU1",
    name: "Product 1",
    description: "Description 1",
    costBasis: 100.0,
    isDeleted: false,
    createdBy: "Mock",
    updatedBy: "Mock",
    deletedBy: "Mock",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    productPictures: [mockProductPicture()],
  );
}


class ProductPicture {
  final int id;
  final int productId;
  final String picture;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductPicture({
    required this.id,
    required this.productId,
    required this.picture,
    required this.createdAt,
    required this.updatedAt,
  });

}

ProductPicture mockProductPicture() {
  return ProductPicture(
    id: 1,
    productId: 1,
    picture: "https://example.com/image1.jpg",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}