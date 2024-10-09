import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController meterController =TextEditingController();
  TextEditingController priceController =TextEditingController();

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
        title: Text('Form Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.yMd().format(_selectedDate),
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Choose Date'),
                  ),
                ],
              ),

              // Name Dropdown
              DropdownButtonFormField<String>(
                hint: Text('Product'),
                value: _selectedName,
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

              // Text Input Field
              TextFormField(
                controller: meterController,
                decoration: const InputDecoration(hintText: 'Amount in Meter'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _inputText = double.parse(value);
                  });
                },
              ),

              // Price Input Field
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(hintText: 'Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _price = double.tryParse(value);
                  });
                },
              ),

              // Username Dropdown
              DropdownButtonFormField<String>(
                hint: Text('Seller'),
                value: _selectedUsername,
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
    );
  }
}
