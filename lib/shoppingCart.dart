import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_detailed/Bloc/cart_bloc/cart_bloc.dart';
import 'package:provider_detailed/Bloc/sample_bloc.dart';
import 'package:provider_detailed/Model/productModel.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) => (state is CartInitial)
            ? CupertinoActivityIndicator()
            : (state is CartLoaded)
                ? ListView.builder(
                    itemCount:
                        BlocProvider.of<CartBloc>(context).cartProduct.length,
                    itemBuilder: (context, index) {
                      Product prd =
                          BlocProvider.of<CartBloc>(context).cartProduct[index];
                      print(prd.productName);
                      return Card(
                        child: Row(
                          children: [
                            Text(
                              prd.productName,
                            ),
                            Text(prd.productQuantity),
                          ],
                        ),
                      );
                    },
                  )
                : (state is CartFail)
                    ? Container(
                        child: Text('Cart failed'),
                      )
                    : Container(
                        child: Text('Empty'),
                      ),
      ),
    );
  }
}
