import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/adding_product.dart';
import 'package:store_ms/database_helper.dart';
import 'model_classes/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Product> addedProduct = [];
  int count = 0;
  @override
  void initState() {
    super.initState();
    updateProductList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اجناس'),
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
      ),
      body: addedProduct.isEmpty?
      Center(child: Text('هیچ جنسی ثبت نشده است', style: TextStyle(fontSize: 35),),):
      ListView.builder(
          itemCount: addedProduct.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
              child: ListTile(
                tileColor: Colors.teal[300],
                iconColor: Colors.white,
                textColor: Colors.white,
                title: Text(addedProduct[index].productName),
                trailing: IconButton(
                  onPressed: (){
                    _deleteProduct(context, addedProduct[index]);
                  },
                  icon: Icon(Icons.delete),),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateToAddProduct(Product(''),);
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.teal[300],
      ),
    );
  }

  void updateProductList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Product>> userListFuture = databaseHelper.getProductList();
      userListFuture.then((productList) {
        setState(() {
          addedProduct = productList;
          count = addedProduct.length;
        });
      });
    });
  }

  void _deleteProduct(BuildContext context, Product product) async {
    var result = await databaseHelper.deleteProduct(product);
    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[400],
          content: Text(
            'جنس مورد نظر حذف شد',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          )));
      updateProductList();
    }
  }

  void navigateToAddProduct(Product product) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AddingProduct(product)));
    if (result == true) {
      updateProductList();
    }
  }
}
