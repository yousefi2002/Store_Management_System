import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:store_ms/database_helper.dart';
import 'package:store_ms/model_classes/product.dart';

class AddingProduct extends StatefulWidget {
  final Product product;
  const AddingProduct(this.product, {super.key});

  @override
  State<AddingProduct> createState() => _AddingProductState(this.product);
}

class _AddingProductState extends State<AddingProduct> {
  _AddingProductState(this.product);
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController productNameController = TextEditingController();

  Product product;
  String? productName;

  void saveProduct() async {
    if (productNameController.text.isEmpty) {
      DelightToastBar(
        builder: (BuildContext context) {
          return const ToastCard(
            color: Colors.red,
            title: Text(
              'Pleas fill out all fields',
            style: TextStyle(color: Colors.white),
            ),
          );
        },
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: Durations.extralong4,
        ).show(
        context,
      );
      return;
    }
    product = Product(productName);
    int result;
    if (product.id != null) {
      result = await databaseHelper.updateProduct(product);
    } else {
      result = await databaseHelper.insertProduct(product);
    }

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.grey,
        content: Text('Data saved successfully',
            style: TextStyle(color: Colors.black)),
      ));
      productNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content:
            Text('Failed to save data', style: TextStyle(color: Colors.white)),
      ));
      return;
    }

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal,
        title: const Text('Add Product'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            left: 30,
            top: 115,
            right: 30,
            bottom: 115,
            child: Container(
              width: 400,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.orange[300],
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: productNameController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelStyle: const TextStyle(color: Colors.white),
                        prefixIcon: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                        ),
                        label: const Text('Product Name'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          productName = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {
                        saveProduct();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Save'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
