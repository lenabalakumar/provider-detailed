void main() {

  Product found = products.firstWhere((e) => e.productID == p2.productID, );

  print(found.productID);

  print(int.parse(found.productQuantity) +1);


}

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


Product p1 = Product(productName: 'Marie', productID: '1', productPrice: '10', productSKU: '500g', productQuantity: '17', productBrand: 'Britannia');

Product p2 = Product(productName: 'Marie', productID: '1', productPrice: '10', productSKU: '500g', productQuantity: '13', productBrand: 'Britannia');

List<Product> products = [p1,p2];
