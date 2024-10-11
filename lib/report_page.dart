import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DateTime? startDate;
  DateTime? endDate;
  String? selectedProduct;
  String? selectedUser;

  final List<String> products = ['Product 1', 'Product 2', 'Product 3']; // Dummy data
  final List<String> users = ['User 1', 'User 2', 'User 3']; // Dummy data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
        title: Text('Report Page'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date range picker
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
                    startDate = picked.start;
                    endDate = picked.end;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.date_range),
                  Text('Pick Date Range'),
                ],
              ),
            ),
            if (startDate != null && endDate != null)
              Text('Selected: ${DateFormat('yyyy-MM-dd').format(startDate!)} to ${DateFormat('yyyy-MM-dd').format(endDate!)}'),
            // Product Dropdown
            SizedBox(height: 10,),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[300]!, width: 1.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[300]!, width: 1.5),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              dropdownColor: Colors.teal[200],
              value: selectedProduct,
              hint: Text('Select Product'),
              items: products.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedProduct = newValue;
                });
              },
            ),
            SizedBox(height: 10,),
            // User Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[300]!, width: 1.5),
                  borderRadius: BorderRadius.circular(25),
                  ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal[300]!, width: 1.5),
                  borderRadius: BorderRadius.circular(25),
                  ),
              ),
              dropdownColor: Colors.teal[200],
              value: selectedUser,
              hint: Text('Select User'),
              items: users.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedUser = newValue;
                });
              },
            ),
            SizedBox(height: 10,),
            // Search Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[300],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Trigger your search query here
                if (startDate != null && endDate != null && selectedProduct != null && selectedUser != null) {
                  _searchReports(startDate!, endDate!, selectedProduct!, selectedUser!);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded),
                  Text('Search'),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _searchReports(DateTime start, DateTime end, String product, String user) {
    // Query your database and fetch the data here
    // Use your DatabaseHelper class or query the database with raw SQL
  }
}
// Future<List<Map<String, dynamic>>> getReports(DateTime startDate, DateTime endDate, String product, String user) async {
//   final db = await database;
//   return await db.rawQuery(
//     'SELECT * FROM Transactions JOIN Products ON Transactions.productId = Products.productId '
//         'JOIN Users ON Transactions.userId = Users.userId WHERE transactionDate BETWEEN ? AND ? '
//         'AND Products.productName = ? AND Users.userName = ?',
//     [startDate.toIso8601String(), endDate.toIso8601String(), product, user],
//   );
// }SELECT * FROM Transactions
// // JOIN Products ON Transactions.productId = Products.productId
// // JOIN Users ON Transactions.userId = Users.userId
// // WHERE transactionDate BETWEEN ? AND ?
// // AND Products.productId = ?
// // AND Users.userId = ?

//
