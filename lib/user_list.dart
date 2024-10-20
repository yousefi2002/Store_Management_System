import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/adding_users.dart';
import 'package:store_ms/database_helper.dart';
import 'model_classes/user.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<User> addedUsers = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    updateUsersList();
  }
  @override
  Widget build(BuildContext context) {
    updateUsersList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        backgroundColor: Colors.teal[300],
        foregroundColor: Colors.white,
      ),
      body: addedUsers.isEmpty
          ? const Center(
              child: Text(
                'No user added',
                style: TextStyle(fontSize: 35),
              ),
            )
          : ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
                  child: ListTile(
                    tileColor: Colors.teal[300],
                    title: Text(
                        "${addedUsers[index].userName} ${addedUsers[index].userLastName}"),
                    subtitle: Text(addedUsers[index].phoneNumber),
                    trailing: IconButton(
                        onPressed: () {
                          _deleteUser(context, addedUsers[index]);
                        }, icon: const Icon(Icons.delete)),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddUsers(User('', '', ''),);
        },
        backgroundColor: Colors.teal[300],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void updateUsersList() {
    Future<Database> dbFuture = databaseHelper.initDatabase();
    dbFuture.then((database) {
      Future<List<User>> userListFuture = databaseHelper.getUsersList();
      userListFuture.then((userList) {
        setState(() {
          addedUsers = userList;
          count = addedUsers.length;
        });
      });
    });
  }

  void _deleteUser(BuildContext context, User user) async{
    var result = await databaseHelper.deleteUser(user);
    if (result != 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[400],
          content: const Text(
            'Sold item got deleted',
            style: TextStyle(color: Colors.black),
          )));
      updateUsersList();
    }
  }

  void navigateToAddUsers(User user) async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => AddingUsers(user)));
    if (result == true) {
      updateUsersList();
    }
  }
}
