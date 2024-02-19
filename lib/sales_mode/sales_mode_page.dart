import 'package:flutter/material.dart';
import 'package:paloma_task/models/product_model.dart';

import '../services/db_services.dart';

class SalesModePage extends StatefulWidget {
  const SalesModePage({Key? key}) : super(key: key);

  @override
  State<SalesModePage> createState() => _SalesModePageState();
}

class _SalesModePageState extends State<SalesModePage> {
  int tapIndex = 0;
  int? removeIndex;

  bool isLoading = false;
  List<ProductModel>? items;
  List<ProductModel>? baskets;

  Future getItems() async {
    setState(() {
      isLoading = true;
    });
    List<Map<String,dynamic>> enter = await SqliteService().getEnter1();
    if(enter.isEmpty){
      await SqliteService().createBasket();
      await SqliteService().createProduct();
    }
    await SqliteService().createEnter1();
    baskets = await SqliteService().getBasket();
    items = await SqliteService().getProduct();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  void changeIndex(int index) {
    setState(() {
      tapIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Column(
            children: <Widget>[
              Row(
                children: [
                  TabWidget(
                    tabChange: () {
                      changeIndex(0);
                    },
                    tabColor:
                        tapIndex == 0 ? Colors.blue : Colors.grey.shade100,
                    title: "товары (2300)",
                    textColor: tapIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  TabWidget(
                    tabChange: () {
                      changeIndex(1);
                    },
                    tabColor:
                        tapIndex == 1 ? Colors.blue : Colors.grey.shade100,
                    title: "параметры",
                    textColor: tapIndex == 1 ? Colors.blue : Colors.grey,
                  ),
                ],
              ),
              Column(
                children: List.generate(
                  baskets?.length ?? 0,
                  (index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color:
                          removeIndex == index ? Colors.indigo.shade100 : null,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              baskets?[index].name ??
                                  "" +
                                      "${baskets![index].price * baskets![index].commonNumber}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              baskets?[index].commonNumber.toString() ?? "",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  removeIndex = index;
                                });
                              },
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        removeIndex == index
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red),
                                      child: Text(
                                        "Удалить из счета",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.indigo.shade700),
                                      child: Text(
                                        "Изменить цену",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                        child: Row(
                          children: [
                            DishWidget(title: "1 блюда"),
                            SizedBox(
                              width: 10,
                            ),
                            DishWidget(title: "2 блюда"),
                          ],
                        ),
                      ),
                      GridView.count(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / 300,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        crossAxisCount: 2,
                        children: List.generate(
                            items?.length ?? 0,
                            (index) => ProductItem(
                                image: "assets/images/cola.png",
                                name: items?[index].name ?? "",
                                itemCount: items?[index].commonNumber ?? 0,
                                price: items?[index].price ?? 0)),
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: "Поиск",
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    )),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.itemCount,
      required this.price})
      : super(key: key);
  final String image;
  final String name;
  final int itemCount;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.center,
      height: 100,
      width: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                image,
                height: 60,
                width: 50,
              ),
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price.toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "склад: $itemCount",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class DishWidget extends StatelessWidget {
  final String title;

  const DishWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class TabWidget extends StatelessWidget {
  const TabWidget(
      {Key? key,
      required this.tabChange,
      required this.tabColor,
      required this.title,
      required this.textColor})
      : super(key: key);
  final VoidCallback tabChange;
  final Color tabColor;
  final Color textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: tabChange,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border(
              bottom: BorderSide(color: tabColor, width: 2),
              top: const BorderSide(color: Colors.grey, width: 2),
            ),
          ),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
