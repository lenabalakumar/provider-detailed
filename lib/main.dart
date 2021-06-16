import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider_detailed/Bloc/cart_bloc/cart_bloc.dart';
import 'package:provider_detailed/Bloc/sample_bloc.dart';
import 'package:provider_detailed/providers/product_provider.dart';
import 'package:provider_detailed/shoppingCart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      BlocProvider(
        create: (context) => CartBloc(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      )
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    productProvider.fetchProductData();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(CupertinoIcons.shopping_cart),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ShoppingCart(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartInitial) {
                      return CupertinoActivityIndicator();
                    } else if (state is CartLoaded) {
                      return Text(
                        //(state.products.length).toString(),
                        BlocProvider.of<CartBloc>(context)
                            .cartProduct
                            .length
                            .toString(),
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.bold),
                      );
                    } else if (state is CartFail) {
                      return Container();
                    } else
                      return Container();
                  },
                ),
                backgroundColor: Colors.red,
                radius: 10,
              ),
            ),
          ],
        ),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: productProvider.getTopProductsList.length,
                  itemBuilder: (context, index) {
                    var data = productProvider.getTopProductsList;
                    return BlocProvider(
                      create: (_) => SampleBloc(),
                      child: Card(
                        child: BlocBuilder<SampleBloc, CounterState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Text(data[index].productName),
                                MaterialButton(
                                  onPressed: () {
                                    // context
                                    //     .read<SampleBloc>()
                                    //     .add(IncrementEvent());
                                    BlocProvider.of<SampleBloc>(context).add(
                                        IncrementEvent(
                                            quantity: int.parse(
                                                data[index].productQuantity)));
                                  },
                                  child: Icon(Icons.add),
                                ),
                                Text(BlocProvider.of<SampleBloc>(context)
                                    .counter
                                    .toString()),
                                MaterialButton(
                                  onPressed: () {
                                    // context
                                    //     .read<SampleBloc>()
                                    //     .add(DecrementEvent());
                                    BlocProvider.of<SampleBloc>(context).add(
                                        DecrementEvent(
                                            quantity: int.parse(
                                                data[index].productQuantity)));
                                  },
                                  child: Icon(Icons.remove),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      BlocProvider.of<CartBloc>(context)
                                          .add(AddToCart(prod: data[index])),
                                  icon: Icon(Icons.add_shopping_cart),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  }),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartInitial) {
                  return CupertinoActivityIndicator();
                } else if (state is CartLoaded) {
                  if (BlocProvider.of<CartBloc>(context).cartProduct.length ==
                      0) {
                    return Container();
                  } else {
                    return Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.green,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              blurRadius: 1,
                              offset: Offset(1, 2),
                              color: Colors.green.withOpacity(0.5)),
                        ],
                      ),
                      child: FittedBox(
                        child: RawMaterialButton(
                          elevation: 1.0,
                          shape: new CircleBorder(),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: 22,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '(${BlocProvider.of<CartBloc>(context).cartProduct.length.toString()})',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  // return Text(
                  //   //(state.products.length).toString(),
                  //   BlocProvider.of<CartBloc>(context)
                  //       .cartProduct
                  //       .length
                  //       .toString(),
                  //   style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  // );
                } else if (state is CartFail) {
                  return Container();
                } else
                  return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
