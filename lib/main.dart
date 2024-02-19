import 'package:flutter/material.dart';
import 'package:paloma_task/cashier/cashier_page.dart';
import 'package:paloma_task/sales_mode/sales_mode_page.dart';
import 'package:paloma_task/services/db_services.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'SQLite Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  PageController pageController = PageController();

  void changeIndex(index){
    Navigator.pop(context);
    setState(() {
      pageIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(pageIndex==0?"Кассир":pageIndex==1?"Официант":pageIndex==2?"Режим продаж":"Склад"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Иван Иванов Иванович",style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue,fontSize: 22),),
                    Text("сотрудник",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.blue),),
                  ],
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.sync,
                  color: Colors.blue.shade800,
                ),
                title: Text("Синхронизация"),
                subtitle: Text("19.04.2022 15:04"),
              ),
              ListTile(
                onTap: (){
                  changeIndex(0);
                  pageController.jumpToPage(0);
                },
                leading: Icon(
                  Icons.calculate,
                  color: Colors.blue.shade800,
                ),
                title: Text("Кассир"),
              ),
              ListTile(
                onTap: (){
                  changeIndex(1);
                  pageController.jumpToPage(1);
                },
                leading: Icon(
                  Icons.accessibility_outlined,
                  color: Colors.blue.shade800,
                ),
                title: Text("Официант"),
              ),
              ListTile(
                onTap: (){
                  changeIndex(2);
                  pageController.jumpToPage(2);
                },
                leading: Icon(
                  Icons.local_mall_outlined,
                  color: Colors.blue.shade800,
                ),
                title: Text("Режим продажи"),
              ),
              ListTile(
                onTap: (){
                  changeIndex(3);
                  pageController.jumpToPage(3);
                },
                leading: Icon(
                  Icons.warehouse,
                  color: Colors.blue.shade800,
                ),
                title: Text("Склад"),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.blue.shade800,
                ),
                title: Text("Сменить сотрудника"),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          CashierPage(),
          Scaffold(
            body: Column(
              children: [
                SizedBox(height: 20,),
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    children: [
                      DishWidget(title: "основный зал"),
                      SizedBox(
                        width: 10,
                      ),
                      DishWidget(title: "летка"),
                    ],
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.yellow.shade100
                                ),
                                child: Icon(Icons.receipt,color: Colors.indigoAccent,),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Vip 1",
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: double.infinity,
                                width: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blue.shade100
                                ),
                                child: Icon(Icons.print_outlined,color: Colors.indigoAccent,),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Vip 2",
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SalesModePage(),
          Scaffold(),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


