class Product {
  String productName;
  String productID;
  String productPrice;
  String productSKU;
  String productQuantity;
  String productBrand;

  Product(
      {required this.productID,
       required this.productName,
       required this.productPrice,
       required this.productQuantity,
       required this.productBrand,
       required this.productSKU});
}
