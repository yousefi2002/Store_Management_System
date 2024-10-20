import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/database_helper.dart';
import 'package:store_ms/model_classes/sell.dart';
import 'model_classes/product.dart';
import 'model_classes/user.dart';

class NewSellPage extends StatefulWidget {
  final Sell sell;
  const NewSellPage(this.sell, {super.key,});

  @override
  _NewSellPageState createState() =>
      _NewSellPageState(this.sell,);
}

class _NewSellPageState extends State<NewSellPage> {
  _NewSellPageState(this.sell);

  DatabaseHelper databaseHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // State variables
  // int count = 0;
  DateTime now = DateTime.now();
  double? _amount;
  String? _selectedDate;
  int? _price;
  Sell sell;
  User? selectedUser;
  Product? selectedProduct;

  // Dropdown options
  List<Product> productName = [];
  List<User> usernames = [];

  @override
  void initState() {
    super.initState();
    updateProductList();
    updateUsersList();
    _updateDateTime();
  }
  void _updateDateTime() {
    setState(() {
      _selectedDate = '${now.year}-${now.month}-${now.day}';
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && "${picked.year}-${picked.month}-${picked.day}" != _selectedDate) {
      setState(() {
        _selectedDate = '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }

  void saveInput() async {
    if (selectedProduct == null || _amount == null || _price == null || selectedUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please fill out all fields', style: TextStyle(color: Colors.white)),
      ));
      return;
    }
  sell = Sell(_selectedDate.toString(), selectedProduct?.productName, _amount, _price, selectedUser?.userName);
    int result;
    if (sell.id != null) {
      result = await databaseHelper.updateSell(sell);
    } else {
      result = await databaseHelper.insertSell(sell);
    }

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.grey,
        content: Text('Data saved successfully', style: TextStyle(color: Colors.black)),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('Failed to save data', style: TextStyle(color: Colors.white)),
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
        backgroundColor: Colors.teal[300],
        title: Text('Inputting'),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 30,
            top: 100,
            right: 30,
            child: Container(
              width: 400,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.teal[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate!,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () => _selectDate(context),
                              child: Text(
                                'Choose Date',
                                style: TextStyle(
                                color: Colors.orange),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Name Dropdown
                      DropdownButtonFormField<Product>(
                        dropdownColor: Colors.teal[200],
                        iconEnabledColor: Colors.white,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: Icon(Icons.production_quantity_limits, color: Colors.white,),
                          border: OutlineInputBorder(
                          ),
                        ),
                        hint: Text(
                          'Product',
                          style: TextStyle(color: Colors.white),
                        ),
                        borderRadius: BorderRadius.circular(25),
                        value: selectedProduct,
                        style: TextStyle(color: Colors.white),
                        items: productName.map((Product name) {
                          return DropdownMenuItem<Product>(
                            value: name,
                            child: Text(name.productName),
                          );
                        }).toList(),
                        onChanged: (Product? newValue) {
                          setState(() {
                            selectedProduct= newValue!;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text Input Field
                      TextFormField(
                        controller: amountController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                              borderRadius: BorderRadius.circular(25),
                            ),
                          prefixIcon: Icon(Icons.numbers, color: Colors.white,),
                            border: OutlineInputBorder(
                            ),
                            label: Text(
                              "Amount",
                              style: TextStyle(color: Colors.white),
                            )),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _amount = double.tryParse(value);

                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Price Input Field
                      TextFormField(
                        controller: priceController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            prefixIcon: Icon(Icons.price_check, color: Colors.white,),
                            border: OutlineInputBorder(
                            ),
                            label: Text(
                              'Price',
                              style: TextStyle(color: Colors.white),
                            )),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _price = int.parse(value);
                            if(_price != null){
                              sell.price = _price!;
                            }
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Username Dropdown
                      DropdownButtonFormField<User>(
                        dropdownColor: Colors.teal[200],
                        iconEnabledColor: Colors.white,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(25),

                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.white,),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        hint: Text(
                          'Seller',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: selectedUser,
                        style: TextStyle(color: Colors.white),
                        items: usernames.map((User user) {
                          return DropdownMenuItem<User>(
                            value: user,
                            child: Text(user.userName),
                          );
                        }).toList(),
                        onChanged: (User? newValue) {
                          setState(() {
                            selectedUser = newValue;
                          });
                        },
                      ),

                      SizedBox(height: 20),
                      // Save Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                          }
                          saveInput();
                          amountController.clear();
                          priceController.clear();
                          setState(() {
                            selectedProduct = null;
                          });
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void updateProductList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Product>> userListFuture = databaseHelper.getProductList();
      userListFuture.then((productList) {
        setState(() {
          productName = productList;
        });
      });
    });
  }

  void updateUsersList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<User>> userListFuture = databaseHelper.getUsersList();
      userListFuture.then((userList) {
        setState(() {
          usernames = userList;
        });
      });
    });
  }
}
