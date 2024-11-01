import 'package:flutter/material.dart';
import 'add_loan_borrow.dart';
import 'models/loan_model.dart';

class LoanPage extends StatefulWidget {
  const LoanPage({super.key});

  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State {
  bool isExpanded = false;
  final List<Loan> items = [
    Loan('djfkidjj', '_reason', 1540),
    Loan('ajkajf', '_reasoijdhf;gjdkfkljn', 1500),
    Loan('dlkrujjfkj', 'lkjdkfsj', 2358),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 35, left: 35),
            padding: const EdgeInsets.only(right: 15, left: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.7),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2000',
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  'کل قرض',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: ExpansionTile(
                    collapsedShape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: Colors.teal, width: 2)),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    leading: IconButton(
                      color: Colors.orange,
                      onPressed: () {},
                      icon: const Icon(Icons.check),
                    ),
                    collapsedTextColor: Colors.teal,
                    collapsedIconColor: Colors.teal,
                    iconColor: Colors.white,
                    backgroundColor: Colors.teal[300],
                    textColor: Colors.white,
                    title: Text('${items[index].amount} <-> ${items[index].date}'),
                    children: <Widget>[
                      ListTile(
                        tileColor: Colors.teal[300],
                        textColor: Colors.white,
                        title: Text(items[index].reason, textAlign: TextAlign.center,),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.teal[300]!)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AddTransactionPage(title: ' قرض ها')),
        ),
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

