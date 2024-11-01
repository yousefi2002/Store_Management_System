import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/database_helper.dart';
import 'package:store_ms/model_classes/expenses.dart';

class ExpensesReport extends StatefulWidget {
  const ExpensesReport({super.key});

  @override
  State<ExpensesReport> createState() => _ExpensesReportState();
}

class _ExpensesReportState extends State<ExpensesReport> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Expenses> expensesListOfItems = [];
  DateTime now = DateTime.now();
  String? startDate;
  String? endDate;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
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
                    Text(
                      'انتخاب تاریخ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (startDate != null && endDate != null)
              Text('Selected: ${startDate!} to ${endDate!}'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[300],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (startDate != null && endDate != null) {
                  updateExpensesList();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_rounded),
                  Text('جستجو'),
                ],
              ),
            ),
            const Divider(
              indent: 25,
              endIndent: 25,
            ),
            expensesListOfItems.isEmpty
                ? const Center(
                    child: Text(
                      'اطلاعات یافت نشد',
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: DataTable(
                            // decoration: ,
                            border: TableBorder.all(color: Colors.teal),
                            columns: [
                              DataColumn(label: Text('شماره')),
                              DataColumn(label: Text('دلیل')),
                              DataColumn(label: Text('قیمت')),
                              DataColumn(label: Text('تاریخ')),
                            ],
                            rows: _buildRows(),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows() {
    return List<DataRow>.generate(expensesListOfItems.length, (index) {
      return DataRow(cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(expensesListOfItems[index].reasonToSpend)),
        DataCell(Text(expensesListOfItems[index].amountToSpend.toString())),
        DataCell(Text(expensesListOfItems[index].date)),
      ]);
    });
  }

  void updateExpensesList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Expenses>> expensesListFuture =
          databaseHelper.getExpenseReport(startDate!, endDate!);
      expensesListFuture.then((expensesList) {
        setState(() {
          expensesListOfItems = expensesList;
          count = expensesListOfItems.length;
          print(count);
        });
      });
    });
  }
}
