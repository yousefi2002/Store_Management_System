import 'package:flutter/material.dart';
import 'borrow.dart';
import 'loan.dart';

class LoanBorrowPage extends StatefulWidget {
  const LoanBorrowPage({super.key});

  @override
  State<LoanBorrowPage> createState() => _LoanBorrowPageState();
}

class _LoanBorrowPageState extends State<LoanBorrowPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('قرضه ها'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.teal[300],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(25),
            child: TabBar(
              tabs: const [
                Tab(text: 'قرض'),
                Tab(text: 'طلب',),
              ],
              labelStyle: const TextStyle(fontSize: 25),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              indicatorColor: Colors.orange,
            ),
          ),
        ),
          body: const TabBarView(
            children: [
              LoanPage(),
              BorrowPage(),
            ],
          ),
      ),
    );
  }
}
