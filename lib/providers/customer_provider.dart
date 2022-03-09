import '../models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../database_handler/database_handler.dart';

class CustomerProvider with ChangeNotifier  {
 List<Customer>  _items=[
   Customer(
     id: "74125603",
     firstName: "mehdi",
     lastName: "musavand",
     bankAccountNumber: "1234567890",
     dateOfBirth: DateTime.now(),
     email: "mehdimosavand@gmail.com",
     phoneNumber: "9124543156"
   )
 ];
 List<Customer> get  items  {   
    
    try{
       var db= DatabaseHandler();
       db.retrieveCustomers().then((value) => _items);     
       
    }
    catch(error)
    {
       print("error update in db");  
    }
    
     return  [..._items];
}
Customer findById(String  inputId)
{
    return _items.firstWhere((element) => element.id==inputId);
}
void addCustomer(Customer  customer)
  {
    try{
       var db= DatabaseHandler();
       db.insertCustomer(customer);
    }
    catch(error)
    {
       print("error insert in db");  
    }
     final newCustomer=Customer(
       id: DateTime.now().toString() ,
       firstName: customer.firstName,
       lastName: customer.lastName,
       bankAccountNumber: customer.bankAccountNumber,
       dateOfBirth: customer.dateOfBirth,
       email: customer.email,
       phoneNumber: customer.phoneNumber,

       );
    _items.add(newCustomer);
     notifyListeners();
  }
 void updateCustomer(String id,Customer  customer)
  {
    try{
       var db= DatabaseHandler();
       db.updateCustomer(id,customer);
    }
    catch(error)
    {
       print("error update in db");  
    }
    final  index=_items.indexWhere((element) => element.id==id);
    if(index>=0)
    {
    _items[index]=customer;
    notifyListeners();
    }
  }
  void deleteCustomer(String id){
    try{
       var db= DatabaseHandler();
       db.deleteCustomer(id);
    }
    catch(error)
    {
       print("error delete in db");  
    }
    _items.removeWhere((element) => element.id==id);
    notifyListeners();
  }
}
