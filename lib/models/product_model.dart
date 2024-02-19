class ProductModel{
  String name;
  int commonNumber;
  int price;

  ProductModel({required this.name,required this.commonNumber,required this.price});

  ProductModel.fromMap(Map<dynamic, dynamic> item):
        name= item["name"], commonNumber= item["commonNumber"], price= item["price"];

  Map<String, dynamic> toMap(){
    return {'name': name,'commonNumber':commonNumber,'price': price};
  }
}