import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider_detailed/Model/productModel.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> topProductsData = [];

  Product product = Product(
      productID: "",
      productName: "",
      productPrice: "",
      productQuantity: "",
      productBrand: "",
      productSKU: "");

  fetchProductData() async {
    List<Product> tempTopProductsData = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("TopProducts").get();

    snapshot.docs.forEach(
      (element) {
        product = Product(
          productID: element.get("productID"),
          productName: element.get("productName"),
          productPrice: element.get("productPrice"),
          productQuantity: element.get("productQuantity"),
          productBrand: element.get("productBrand"),
          productSKU: element.get("productSKU"),
        );
        tempTopProductsData.add(product);
      },
    );
    topProductsData = tempTopProductsData;
    notifyListeners();
  }

  List<Product> get getTopProductsList => topProductsData;
}
