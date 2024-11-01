import 'package:flutter/material.dart';
import 'package:store_ms/expenses_report.dart';
import 'package:store_ms/sales_report.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            bottom:  PreferredSize(
              preferredSize: Size.fromHeight(45),
              child: Expanded(
                child: TabBar(
                  tabs: [
                    Tab(
                      text: 'گزارش فروش',
                      icon: Icon(Icons.report_outlined),
                    ),
                    Tab(
                      text: 'گزارش خرجی',
                      icon: Icon(Icons.monetization_on_outlined),
                    ),
                  ],
                  dividerColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey[400],
                  indicatorColor: Colors.grey[400],
                ),
              ),
            ),
            backgroundColor: Colors.teal[300],
            foregroundColor: Colors.white,
            title: const Text('گزارشات'),
            elevation: 0,
          ),
          body: TabBarView(
            children: [
              SalesReport(),
              ExpensesReport(),
            ],
          )),
    );
  }
}

