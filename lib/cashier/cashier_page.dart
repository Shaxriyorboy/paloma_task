import 'package:flutter/material.dart';
import 'package:paloma_task/models/cashier_mode.dart';
import 'package:paloma_task/services/db_services.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({Key? key}) : super(key: key);

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  bool isLoading = false;
  List<CashierModel>? items;

  Future getItems()async{
    setState(() {
      isLoading = true;
    });
    List<Map<String,dynamic>> enter = await SqliteService().getEnter();
    if(enter.isEmpty){
      await SqliteService().createItem();
    }
    await SqliteService().createEnter();
    items = await SqliteService().getItems();
    print(items);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return !isLoading?ListView.builder(
      itemCount: items?.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        height: 80,
        child: Row(
          children: [
            Container(
              height: 120,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow.shade100
              ),
              child: Icon(items?[index].isPay==0? Icons.receipt:items?[index].isPay==1?Icons.payments_outlined:Icons.print,color: Colors.indigoAccent,),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Посетитель",style: Theme.of(context).textTheme.bodyLarge,),Spacer(),
                        Text(items?[index].items??""),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(items?[index].name??"",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),),Spacer(),
                        Text(items?[index].price.toString()??"",style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700,fontSize: 22),),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }):const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
