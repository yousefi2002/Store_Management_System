import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_ms/model_classes/sell.dart';
import 'package:store_ms/model_classes/expenses.dart';
import 'package:store_ms/model_classes/product.dart';
import 'package:store_ms/model_classes/user.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // singleton database helper
  static Database? _database;

  String sellTable = 'inputting_table';
  String inId = 'id';
  String inDate = 'date';
  String inProductName = 'pr_name';
  String inAmount = 'amount';
  String inPrice = 'price';
  String inUser = 'user';

//-------------------------------
  String expensesTable = 'outputting_table';
  String outId = 'id';
  String outDate = 'date';
  String outReasonToSpend = 'reason_to_spend';
  String outAmountToSpend = 'amount_to_spend';

//---------------------------------
  String usersTable = 'users_table';
  String userId = 'id';
  String userName = 'user_name';
  String userLastName = 'user_last_name';
  String userPhoneNumber = 'phone_number';

//---------------------------
  String productTable = 'product_table';
  String productId = 'id';
  String productName = 'product_name';


  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/store.db';

    var storeDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return storeDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''
        CREATE TABLE $sellTable
        ($inId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $inDate TEXT, $inProductName TEXT, 
        $inAmount REAL, $inPrice INTEGER, 
        $inUser TEXT,
        FOREIGN KEY ($inUser) REFERENCES $usersTable ($userName),
        FOREIGN KEY ($inProductName) REFERENCES $productTable ($productName))
        ''');

    await db.execute(
        '''
        CREATE TABLE $expensesTable
        ($outId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $outDate TEXT, $outReasonToSpend TEXT, 
        $outAmountToSpend INTEGER)
        ''');

    await db.execute(
        '''
        CREATE TABLE $usersTable
        ($userId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $userName TEXT, $userLastName TEXT, 
        $userPhoneNumber TEXT)
        ''');

    await db.execute(
        '''
        CREATE TABLE $productTable
        ($productId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $productName TEXT)
        ''');
  }

  // get from database in form of map
  Future<List<Map<String, dynamic>>> getSellMapList() async {
    Database db = await database;

    var result = await db.query(sellTable, orderBy: '$inId DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getExpensesMapList() async {
    Database db = await database;

    var result = await db.query(expensesTable, orderBy: '$outId DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getUsersMapList() async {
    Database db = await database;

    var result = await db.query(usersTable, orderBy: '$userId DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await database;

    var result = await db.query(productTable, orderBy: '$productId DESC');
    return result;
  }

  // update records
  Future<int> updateSell(Sell sell) async {
    var db = await database;
    var result = await db.update(
        sellTable, sell.toMap(), where: '$inId = ?', whereArgs: [sell.id]);
    return result;
  }

  Future<int> updateExpenses(Expenses expenses) async {
    var db = await database;
    var result = await db.update(
        sellTable, expenses.toMap(), where: '$inId = ?',
        whereArgs: [expenses.id]);
    return result;
  }

  Future<int> updateUsers(User user) async {
    var db = await database;
    var result = await db.update(
        sellTable, user.toMap(), where: '$inId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> updateProduct(Product product) async {
    var db = await database;
    var result = await db.update(sellTable, product.toMap(), where: '$inId = ?',
        whereArgs: [product.id]);
    return result;
  }

  //insert into database

  Future<int> insertSell(Sell sell) async {
    Database db = await database;
    var result = await db.insert(sellTable, sell.toMap());
    return result;
  }

  Future<int> insertExpenses(Expenses expenses) async {
    Database db = await database;
    var result = await db.insert(expensesTable, expenses.toMap());
    return result;
  }

  Future<int> insertUser(User user) async {
    Database db = await database;
    var result = await db.insert(usersTable, user.toMap());
    return result;
  }

  Future<int> insertProduct(Product product) async {
    Database db = await database;
    var result = await db.insert(productTable, product.toMap());
    return result;
  }

  // delete table

  Future<int> truncateSellTable() async {
    var db = await database;
    int result = await db.delete(sellTable);
    return result;
  }

  Future<int> truncateExpensesTable() async {
    var db = await database;
    int result = await db.delete(expensesTable);
    return result;
  }

  Future<int> truncateProductTable() async {
    var db = await database;
    int result = await db.delete(productTable);
    return result;
  }

  Future<int> truncateUsersTable() async {
    var db = await database;
    int result = await db.delete(usersTable);
    return result;
  }

  // delete a particular item
  Future<int> deleteSell(Sell sell) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $sellTable WHERE $inId = ${sell.id}');
    return result;
  }

  Future<int> deleteProduct(Product product) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $productTable WHERE $productId = ${product.id}');
    return result;
  }

  Future<int> deleteUser(User user) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $usersTable WHERE $userId = ${user.id}');
    return result;
  }

  Future<int> deleteExpenses(Expenses expenses) async {
    var db = await database;
    int result = await db.rawDelete(
        'DELETE FROM $expensesTable WHERE $outId= ${expenses.id}');
    return result;
  }
  // get from database in form of list

  Future<List<Sell>> getSellList() async {
    var userMapList = await getSellMapList();
    int count = userMapList.length;

    List<Sell> sellList = [];
    for (int i = 0; i < count; i++) {
      sellList.add(Sell.fromMapObject(userMapList[i]));
    }
    return sellList;
  }

  Future<List<Expenses>> getExpensesList() async {
    var expensesMapList = await getExpensesMapList();
    int count = expensesMapList.length;

    List<Expenses> expensesList = [];
    for (int i = 0; i < count; i++) {
      expensesList.add(Expenses.fromMapObject(expensesMapList[i]));
    }
    return expensesList;
  }

  Future<List<Product>> getProductList() async {
    var productMapList = await getProductMapList();
    int count = productMapList.length;

    List<Product> productList = [];
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMapObject(productMapList[i]));
    }
    return productList;
  }

  Future<List<User>> getUsersList() async {
    var userMapList = await getUsersMapList();
    int count = userMapList.length;

    List<User> userList = [];
    for (int i = 0; i < count; i++) {
      userList.add(User.fromMapObject(userMapList[i]));
    }
    return userList;
  }
  // searching for today's data ------------------------------------------------
  Future <List<Map<String, dynamic>>> salesOfToday(String mainPageDate)async{
    Database db = await database;
    var result = db.query(sellTable, where: '$inDate = ?', whereArgs: [mainPageDate]);
    return result;
  }

  Future<List<Sell>> getSalesOfToday(String mainPageDate) async{
    var listOfTodaySales = await salesOfToday(mainPageDate);
    int count = listOfTodaySales.length;

    List<Sell> salesList = [];
    for(int i = 0; i < count; i++){
      salesList.add(Sell.fromMapObject(listOfTodaySales[i]));
    }
    return salesList;
  }

  Future <List<Map<String, dynamic>>> expensesOfToday(String expensesPageDate)async{
    Database db = await database;
    var result = db.rawQuery('SELECT * FROM $expensesTable WHERE $outDate = ?', [expensesPageDate]);
    return result;
  }

  Future<List<Expenses>> getExpensesOfToday(String expensesPageDate) async{
    var listOfTodayExpenses = await expensesOfToday(expensesPageDate);
    int count = listOfTodayExpenses.length;

    List<Expenses> salesList = [];
    for(int i = 0; i < count; i++){
      salesList.add(Expenses.fromMapObject(listOfTodayExpenses[i]));
    }
    print(salesList);
    return salesList;
  }
  // getting total earned money
  Future<int> getTotalSalesForDay(String todayDate) async{
    Database db = await database;
    var result = await db.rawQuery(
      """
      SELECT SUM($inPrice) AS total_sales 
      From $sellTable 
      WHERE $inDate = ?
      """, [todayDate]);
    if(result.isNotEmpty && result[0]['total_sales'] != null){
      return result[0]['total_sales'] as int;
    }
    return 0;
  }
  Future<int> getTotalExpensesForDay(String todayExpensesDate) async{
    Database db = await database;
    var result = await db.rawQuery(
        """
      SELECT SUM($outAmountToSpend) AS total_sales 
      From $expensesTable 
      WHERE $outDate = ?
      """, [todayExpensesDate]);
    if(result.isNotEmpty && result[0]['total_sales'] != null){
      return result[0]['total_sales'] as int;
    }
    return 0;
  }
// sales report

  Future<List<Map<String, dynamic>>> getReportMapList(String startDate, String endDate, List<Product> products, List<User> users) async {
    Database db = await database;

    // Create a list of product names and user names to use in the query
    List<String> productNames = products.map((product) => product.productName).toList();
    List<String> userNames = users.map((user) => user.userName).toList();

    // Create comma-separated strings for SQL placeholders
    String productPlaceholders = productNames.map((_) => '?').join(', ');
    String userPlaceholders = userNames.map((_) => '?').join(', ');

    // Prepare the SQL query with placeholders
    var result = await db.rawQuery(
      '''
    SELECT *
    FROM $sellTable
    WHERE $inDate BETWEEN ? AND ?
    AND $inProductName IN ($productPlaceholders)
    AND $inUser IN ($userPlaceholders)
    ORDER BY $sellTable.$inDate
    ''',
      [startDate, endDate, ...productNames, ...userNames],
    );

    return result;
  }



  Future<List<Sell>> getReportList(String startDate, String endDate, List<Product> products, List<User> users) async{
    var reportList = await getReportMapList(startDate, endDate, products, users);
    int count = reportList.length;

    List<Sell> report = [];
    for(int i = 0; i < count; i++){
      report.add(Sell.fromMapObject(reportList[i]));
    }
    return report;
  }

  Future<List<Map<String, dynamic>>> expenseReportMap(String startDate, String endDate) async{
    Database db = await database;
    var result = db.rawQuery('SELECT * FROM $expensesTable WHERE $outDate BETWEEN ? AND ?', [startDate, endDate]);
    return result;
  }

  Future<List<Expenses>> getExpenseReport(String startDate, String endDate) async{
    var reportList = await expenseReportMap(startDate, endDate);
    int count = reportList.length;

    List<Expenses> expensesReportList = [];
    for(int i = 0; i < count; i++){
      expensesReportList.add(Expenses.fromMapObject(reportList[i]));
    }
    return expensesReportList;
  }
}
