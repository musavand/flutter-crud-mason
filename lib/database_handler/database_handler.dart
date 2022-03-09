import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/customer.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'crud_mason.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE customers(id TEXT PRIMARY KEY, email TEXT NOT NULL, phoneNumber TEXT NOT NULL,firstName TEXT NOT NULL, lastName TEXT NOT NULL,bankAccountNumber TEXT NOT NULL, dateOfBirth TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }


  Future<String> insertCustomer(Customer customer) async {
    try
    {
    final Database db = await initializeDB();
    await db.insert('customers', customer.toMap());
    return "succes";
    }
    catch(error){
    return "failed";
    }
  }

  Future<List<Customer>> retrieveCustomers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('customers');
    return queryResult.map((e) => Customer.fromMap(e)).toList();
  }
  Future<void> deleteCustomer(String id) async {
    final db = await initializeDB();
    await db.delete(
      'customers',
      where: "id = ?",
      whereArgs: [id],
    );
  }
  Future<void> updateCustomer(String id,Customer  customer) async {
    final db = await initializeDB();
    await db.update(
      'customers',
      customer.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }
}