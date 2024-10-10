import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController meterController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // State variables
  DateTime _selectedDate = DateTime.now();
  String? _selectedName;
  double? _inputText;
  double? _price;
  String? _selectedUsername;

  // Dropdown options
  List<String> names = ['John', 'Doe', 'Smith'];
  List<String> usernames = ['user1', 'user2', 'user3'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
                            DateFormat.yMd().format(_selectedDate),
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
                      DropdownButtonFormField<String>(
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
                        value: _selectedName,
                        style: TextStyle(color: Colors.white),
                        items: names.map((String name) {
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedName = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Text Input Field
                      TextFormField(
                        controller: meterController,
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
                            _inputText = double.parse(value);
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Price Input Field
                      TextFormField(
                        controller: priceController,
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
                            _price = double.tryParse(value);
                          });
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Username Dropdown
                      DropdownButtonFormField<String>(
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
                        value: _selectedUsername,
                        style: TextStyle(color: Colors.white),
                        items: usernames.map((String username) {
                          return DropdownMenuItem<String>(
                            value: username,
                            child: Text(username),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedUsername = newValue;
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
                            // Save form data or perform action
                            print('Date: $_selectedDate');
                            print('Name: $_selectedName');
                            print('Text: $_inputText');
                            print('Price: $_price');
                            print('Username: $_selectedUsername');
                          }
                          meterController.clear();
                          priceController.clear();
                          setState(() {
                            _selectedName = null;
                          });
                        },
                        child: Text('Save'),
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
}
