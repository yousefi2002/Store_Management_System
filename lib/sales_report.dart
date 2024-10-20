import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'model_classes/product.dart';
import 'model_classes/sell.dart';
import 'model_classes/user.dart';

class SalesReport extends StatefulWidget {
  const SalesReport({super.key});

  @override
  State<SalesReport> createState() => _SalesReportState();
}

class _SalesReportState extends State<SalesReport> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  int? count;
  String? startDate;
  String? endDate;
  String? selectedProduct;
  String? selectedUser;
  Product? products;
  User? users;

  List<Product> _product = [];
  List<Product> _selectedProduct = [];
  List<User> _user = [];
  List<User> _selectedUser = [];
  List<Sell> _report = [];
  @override
  void initState() {
    super.initState();
    updateProductList();
    updateUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[300],
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                final picked = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    startDate =
                        "${picked.start.year}-${picked.start.month}-${picked.start.day}";
                    endDate =
                        "${picked.end.year}-${picked.end.month}-${picked.end.day}";
                  });
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.date_range),
                  Text('Pick Date Range'),
                ],
              ),
            ),
            if (startDate != null && endDate != null)
              Text('Selected: ${startDate!} to ${endDate!}'),
            // Product Dropdown
            const SizedBox(height: 10),
            DropdownSearch<Product>.multiSelection(
              items: _product,
              selectedItems: _selectedProduct,
              dropdownBuilder: _customProductDropDown,
              compareFn: (Product a, Product b) => a.id == b.id,
              popupProps: PopupPropsMultiSelection.menu(
                showSelectedItems: true,
                showSearchBox: true,
                itemBuilder: (context, product, isSelected) {
                  return ListTile(
                    title: Text(product.productName),
                  );
                },
              ),
              onChanged: (List<Product> value) {
                setState(() {
                  _selectedProduct = value;
                });
              },
              clearButtonProps: const ClearButtonProps(isVisible: true),
              dropdownButtonProps: const DropdownButtonProps(isVisible: true),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.teal[300]!, width: 1.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.teal[300]!, width: 1.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Select Product",
                  hintText: "Choose Product",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 10),
            // User Dropdown
            DropdownSearch<User>.multiSelection(
              items: _user,
              selectedItems: _selectedUser,
              dropdownBuilder: _customUserDropDown,
              compareFn: (User a, User b) => a.id == b.id,
              popupProps: PopupPropsMultiSelection.menu(
                showSelectedItems: true,
                showSearchBox: true,
                itemBuilder: (context, user, isSelected) {
                  return ListTile(
                    title: Text(user.userName),
                  );
                },
              ),
              onChanged: (List<User> value) {
                setState(() {
                  _selectedUser = value;
                });
              },
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
              ),
              dropdownButtonProps: const DropdownButtonProps(isVisible: true),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.teal[300]!, width: 1.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.teal[300]!, width: 1.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelText: "Select User",
                  hintText: "Choose User",
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            SizedBox(height: 10),
            // Search Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[300],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (startDate != null &&
                    endDate != null &&
                    _selectedUser.isNotEmpty &&
                    _selectedProduct.isNotEmpty) {
                  updateReportList();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded),
                  Text('Search'),
                ],
              ),
            ),
            const Divider(),
            _report.isEmpty
                ? const Center(
                    child: Text(
                      'No Record Found',
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            border: TableBorder.all(color: Colors.teal),
                            columns: const [
                              DataColumn(label: Text('No.')),
                              DataColumn(label: Text('Product Name')),
                              DataColumn(label: Text('Amount')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('User')),
                              DataColumn(label: Text('Date')),
                            ],
                            rows: _buildRows()),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows() {
    return List<DataRow>.generate(_report.length, (index) {
      return DataRow(cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(_report[index].productName)),
        DataCell(Text(_report[index].amount.toString())),
        DataCell(Text(_report[index].price.toString())),
        DataCell(Text(_report[index].user)),
        DataCell(Text(_report[index].date)),
      ]);
    });
  }

  Widget _customProductDropDown(
      BuildContext context, List<Product>? selectedProduct) {
    if (selectedProduct == null || selectedProduct.isEmpty) {
      return Text('No product Selected');
    }
    return Wrap(
      children: selectedProduct
          .map((product) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Chip(
                  label: Text(product.productName),
                  deleteIcon: Icon(Icons.clear),
                  onDeleted: () {
                    setState(() {
                      _selectedProduct.remove(product);
                    });
                  },
                ),
              ))
          .toList(),
    );
  }

  Widget _customUserDropDown(BuildContext context, List<User>? selectedUser) {
    if (selectedUser == null || selectedUser.isEmpty) {
      return Text('No User Selected');
    }
    return Wrap(
      children: selectedUser
          .map((user) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Chip(
                  label: Text(user.userName),
                  deleteIcon: Icon(Icons.clear),
                  onDeleted: () {
                    setState(() {
                      _selectedUser.remove(user);
                    });
                  },
                ),
              ))
          .toList(),
    );
  }

  void updateProductList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Product>> userListFuture = databaseHelper.getProductList();
      userListFuture.then((productList) {
        setState(() {
          _product = productList;
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
          _user = userList;
        });
      });
    });
  }

  void updateReportList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Sell>> userListFuture = databaseHelper.getReportList(
        startDate!,
        endDate!,
        _selectedProduct,
        _selectedUser,
      );
      userListFuture.then((reportList) {
        setState(() {
          _report = reportList;
          count = reportList.length;
        });
      });
    });
  }
}
