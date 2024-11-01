import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/add_expenses.dart';
import 'package:store_ms/database_helper.dart';
import 'model_classes/expenses.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Expenses> _expensesList = [];
  DateTime now = DateTime.now();
  String? expensesPageDate;
  int? numberOfExpenses;
  int? totalExpensesAmount;
  int count = 0;

  void _updateDateTime() {
    setState(() {
      expensesPageDate = '${now.year}-${now.month}-${now.day}';
    });
  }

  Future<void> _getTotalExpensesOfToday() async{
    int expense = await databaseHelper.getTotalExpensesForDay(expensesPageDate!);
    setState(() {
      totalExpensesAmount = expense;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    updateExpensesList();
    _getTotalExpensesOfToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
        title: const Text('خرجی ها'),
      ),
      body: _expensesList.isEmpty
          ? const Center(
              child: Text(
                'چیزی خرج نشده',
                style: TextStyle(fontSize: 45),
              ),
            )
          : Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.7),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              expensesPageDate!,
                              style: const TextStyle(fontSize: 20),
                            )),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _expensesList.length.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Text(
                                  'تعداد خرج',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$totalExpensesAmount',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Text(
                                  'جمع کل',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _expensesList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: ListTile(
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(color: Colors.teal, width: 2),
                            ),
                            textColor: Colors.teal,
                            // tileColor: Colors.teal[300],
                            title: Text(_expensesList[index].reasonToSpend),
                            subtitle: Text(
                              '${_expensesList[index].amountToSpend}',
                            ),
                            onTap: () {},
                            trailing: IconButton(
                              onPressed: () {
                                _deleteExpenses(context, _expensesList[index]);
                              },
                              icon: const Icon(Icons.delete, color: Colors.teal,),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          navigateToAddExpenses(Expenses('', '', 0));
        },
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  void updateExpensesList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<Expenses>> expensesListFuture =
      databaseHelper.getExpensesOfToday(expensesPageDate!);
      expensesListFuture.then((expensesList) {
        setState(() {
          _expensesList = expensesList;
          count = _expensesList.length;
        });
      });
    });
  }
  void _deleteExpenses(BuildContext context, Expenses expenses) async {
    var result = await databaseHelper.deleteExpenses(expenses);
    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[400],
          content: const Text(
            'گزینه مورد نظر حذف شد',
            style: TextStyle(color: Colors.black),
          )));
      updateExpensesList();
      _getTotalExpensesOfToday();
    }
  }

  void navigateToAddExpenses(Expenses expenses) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AddingExpenses(expenses)));
    if (result == true) {
      updateExpensesList();
      if( expensesPageDate == '${now.year}-${now.month}-${now.day}'){
        _getTotalExpensesOfToday();
      }
    }
  }
}
