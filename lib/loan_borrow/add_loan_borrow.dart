import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  final String title;
  const AddTransactionPage({super.key, required this.title});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime now = DateTime.now();
  String startDate = '';
  String? name;
  int? amount;
  void updateTime(){
    startDate = '${now.year}-${now.month}-${now.day}';
  }
  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && '${picked.year}-${picked.month}-${picked.day}' != startDate) {
      setState(() {
        startDate = '${picked.year}-${picked.month}-${picked.day}';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First Date Picker
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(startDate,
                    style: const TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => _startDate(context),
                    child: const Text(
                      'انتخاب تاریخ',
                      style: TextStyle(color: Colors.teal, fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                controller: nameController,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  labelText: 'توضیحات',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amountController,
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                  labelText: 'مقدار',
                  labelStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.monetization_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.teal,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Save Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Save logic here
                    if (nameController.text.isNotEmpty &&
                        amountController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('موفقانه ثبت شد')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('لطفا همه گزینه ها را پر کنید')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  icon: const Icon(Icons.save, color: Colors.white,),
                  label: const Text('ثبت',
                  style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
