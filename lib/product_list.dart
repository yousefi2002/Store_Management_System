import 'package:flutter/material.dart';
import 'package:store_ms/adding_product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}
class Product{
  String name;
  String amount;
  Product(this.name, this.amount);
}

class _ProductListState extends State<ProductList> {
  List<Product> productList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
      ),
      body: productList.isEmpty?
      Center(child: Text('No product added', style: TextStyle(fontSize: 35),),):
      ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(productList[index].name),
              subtitle: Text(productList[index].amount),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddingProduct(),),),
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.teal[300],
      ),
    );
  }
}
