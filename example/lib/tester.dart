import 'dart:io';

import 'package:example/modals.dart';
import 'package:example/res_json.dart';
import 'package:flutter/material.dart';

import 'package:x_pagintor/x_pagintor.dart';

class PagintionTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PagintionTestState();
  }
}

class PagintionTestState extends State<PagintionTest> {
  GlobalKey<XPaginatorState> paginatorGlobalKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Product> products = [];

  String searchKey = "all";
  final TextEditingController _textController = TextEditingController();

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
      list.add(productHomeCart(context, value));
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
        FlatButton(
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
    PagModal pagModal = PagModal.fromJson(jsonData[page - 1], 200);
    return pagModal;
  } catch (e) {
    rethrow;
    if (e is IOException) {
      return PagModal.withError('Please check your internet connection.');
    } else {
      debugPrint(e.toString());
      return PagModal.withError('Something went wrong.');
    }
  }
}

GestureDetector productHomeCart(BuildContext context, Product product) {
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
                                primary: Colors.grey,
                                onPrimary: Colors.red,
                                shadowColor: Colors.red,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
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
