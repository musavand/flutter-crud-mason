import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import '../widgets/customer_item_widget.dart';
import '../screens/edit_customer_screen.dart';
import '../widgets/appdrawer_widget.dart';
class CustomerOverviewScreen extends StatelessWidget {
  
 static  const routename='/customers';
  @override
  Widget build(BuildContext context) {
    final customer=Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List.. '),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add, color: Colors.black), onPressed: (){
            Navigator.of(context).pushNamed(EditCustomerScreen.routename);
          })
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
         
            SizedBox( height: 10,),
            Expanded(
              child: ListView.builder(
              itemCount: customer.items.length,
              itemBuilder: (ctx,i)=>CustomerItemWidget(
                id: customer.items[i].id,              
                email :customer.items[i].email,
                phoneNumber: customer.items[i].phoneNumber,
                     
              )
              ),
              
      )],),
      
    );
  }
}