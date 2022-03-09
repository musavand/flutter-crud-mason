import 'package:flutter/material.dart';
import '../screens/edit_customer_screen.dart';


class AppDrawer extends StatelessWidget {


  
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Customers!'),
            automaticallyImplyLeading: false,
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Customer List'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed('/');
            },            
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Customer'),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(EditCustomerScreen.routename);
            },            
          ),
          Divider(),
          
          
        ],
      ),
    );
  }
}