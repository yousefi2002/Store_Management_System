import 'package:flutter/material.dart';
import 'package:store_ms/adding_users.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}
class Users{
  String name;
  String phoneNumber;
  Users(this.name, this.phoneNumber);
}

class _UserListState extends State<UserList> {
  List<Users> userList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
      ),
      body: userList.isEmpty ?
      Center(child: Text('No user added', style: TextStyle(fontSize: 35),),) :
      ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(userList[index].name),
              subtitle: Text(userList[index].phoneNumber),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddingUsers(),),),
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.teal[300],
      ),
    );
  }
}
