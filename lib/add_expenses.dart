import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:store_ms/database_helper.dart';
import 'model_classes/expenses.dart';

class AddingExpenses extends StatefulWidget {
  final Expenses expenses;
  const AddingExpenses(this.expenses, {super.key});

  @override
  State<AddingExpenses> createState() => _AddingExpensesState(this.expenses);
}

class _AddingExpensesState extends State<AddingExpenses> {
  _AddingExpensesState(this.expenses);

  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController reasonToSpendController = TextEditingController();
  TextEditingController amountSpentController = TextEditingController();

  DateTime now = DateTime.now();
  String? expensesDate;
  int? amountToSpent;
  String? reasonToSpend;
  Expenses expenses;

  void _updateDateTime() {
    setState(() {
      expensesDate = '${now.year}-${now.month}-${now.day}';
    });
  }

  Future<void> saveExpenses() async {
    if (reasonToSpendController.text.isEmpty &&
        amountSpentController.text.isEmpty) {
      DelightToastBar(
              builder: (BuildContext context) {
                return const ToastCard(
                    color: Colors.red,
                    title: Text(
                      'لطفا تمام گزینه ها را پر کنید',
                      style: TextStyle(color: Colors.white),
                    ));
              },
              position: DelightSnackbarPosition.top,
              autoDismiss: true,
              )
          .show(
        context,
      );
      return;
    }
    expenses = Expenses(expensesDate, reasonToSpend, amountToSpent);
    int result;
    if (expenses.id != null) {
      result = await databaseHelper.updateExpenses(expenses);
    } else {
      result = await databaseHelper.insertExpenses(expenses);
    }

    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.grey,
        content: Text('اطلاعات ثبت شد', style: TextStyle(color: Colors.black)),
      ));
      reasonToSpendController.clear();
      amountSpentController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text('متاسفانه اطلاعات ثبت نشد ',
            style: TextStyle(color: Colors.white)),
      ));
      return;
    }
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.teal[300],
        title: const Text('ثبت خرجی'),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.teal[300]),
          child: formInfo(),
        ),
      ),
    );
  }

  Widget formInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    expensesDate!,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          expensesDate =
                              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                        });
                      }
                    },
                    child: Text(
                      'انتخاب تاریخ',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              TextField(
                style: TextStyle(color: Colors.white,),
                controller: reasonToSpendController,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.note_add_rounded,
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    label: Text('دلیل خرج')),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    reasonToSpend = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // Price Input Field
              TextField(
                style: TextStyle(color: Colors.white,),
                controller: amountSpentController,
                decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
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
                    label: Text('مقدار خرج')),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amountToSpent = int.tryParse(value);
                  });
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            saveExpenses();
          },
          child: const Text(
            'ثبت',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
        )
      ],
    );
  }
}
