import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:x_pagintor/x_pagintor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter X Paginator',
      home: PagintionTest(),
    );
  }
}

class PagintionTest extends StatefulWidget {
  const PagintionTest({super.key});

  @override
  State<StatefulWidget> createState() {
    return PagintionTestState();
  }
}

class PagintionTestState extends State<PagintionTest> {
  GlobalKey<XPaginatorState> paginatorGlobalKey = GlobalKey();

  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: XPaginator<PagModal>.gridView(
        key: paginatorGlobalKey,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        pageLoadFuture: (page) =>
            getProductsPagtion(page: page, context: context),
        pageItemsGetter: listItemsGetter,
        listItemBuilder: listItemBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: const BouncingScrollPhysics(),
      ),
    );
  }

  List<dynamic> listItemsGetter(productsData) {
    List<Widget> list = [];
    for (var value in productsData.datat!) {
      list.add(ProductWidget(product: value));
    }
    return list;
  }

  Widget listItemBuilder(value, int index) {
    return value;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: const CircularProgressIndicator(),
    );
  }

  Widget errorWidgetMaker(productsData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(productsData.datat!.length.toString()),
        ),
        TextButton(
          onPressed: retryListener,
          child: const Text('حاول مجداد'),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(productsData) {
    return const Center(
      child: Text('لا يوجد منتجات حالياً'),
    );
  }

  int totalPagesGetter(productsData) {
    return productsData.total;
  }

  bool pageErrorChecker(productsData) {
    return productsData.statusCode != 200;
  }
}

Future<PagModal> getProductsPagtion({
  required int page,
  required BuildContext context,
}) async {
  try {
    //------ replace this with your http request   ------------//
    PagModal pagModal = PagModal.fromJson(jsonData[page - 1], 200);
    return pagModal;
  } catch (e) {
    if (e is IOException) {
      return PagModal.withError('Please check your internet connection.');
    } else {
      debugPrint(e.toString());
      return PagModal.withError('Something went wrong.');
    }
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadowColor: Colors.grey.withOpacity(1),
            elevation: 4,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width / 1.6,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    //"assets/images/logo.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 6,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              product.name!,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'hanimation'),
                            ),
                            Text(
                              product.description ?? "غير متاح حالياً",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'hanimation',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  " الكمية  : ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'hanimation'),
                                ),
                                Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'hanimation'),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "السعر جملة: ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'hanimation'),
                                ),
                                Text(
                                  "${product.price} جنية  ",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'hanimation'),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "السعر قطاعي: ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'hanimation'),
                                ),
                                Text(
                                  "${product.price} جنيه",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'hanimation'),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  backgroundColor: Colors.grey,
                                  shadowColor: Colors.red,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 50),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "فى أنتظار التفعيل",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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

//------ replace server response ------------//
List jsonData = List.generate(30, (index) {
  return {
    "current_page": index,
    "first_page_url": '0',
    "from": 1,
    "last_page": 3,
    "last_page_url": 2,
    "next_page_url": '${index + 1}',
    "per_page": 9,
    "prev_page_url": null,
    "to": 3,
    "total": 90,
    "data": [
      {
        "id": 25,
        "name": "جبنه عبور لاند فيتا ربع كيلو",
        "description": "رابطه 27 علبه - العلبه ربع كيلو",
        "image":
            "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
        "price": "253.5"
      },
      {
        "id": 25,
        "name": "جبنه عبور لاند فيتا ربع كيلو",
        "description": "رابطه 27 علبه - العلبه ربع كيلو",
        "image":
            "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
        "price": "253.5"
      },
      {
        "id": 25,
        "name": "جبنه عبور لاند فيتا ربع كيلو",
        "description": "رابطه 27 علبه - العلبه ربع كيلو",
        "image":
            "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
        "price": "253.5"
      }
    ],
    "status": true,
    "error": null,
    "message": null
  };
});
