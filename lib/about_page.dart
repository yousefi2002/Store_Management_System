import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('About'),
      content: Text('''
      This app is developed to track all your financial information. As an example, you need to know how much you earned today, this month or this year. You can understand what you sold and what product you need. As a result you can manage your business properly. ''',
      textAlign: TextAlign.justify,),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close', style: TextStyle(color: Colors.orange),),
        ),
      ],
    );
  }
}
