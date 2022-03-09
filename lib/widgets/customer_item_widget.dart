import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import '../screens/edit_customer_screen.dart';
class CustomerItemWidget extends StatelessWidget {
  
  final String id;
  final String email;
  final String phoneNumber;
  CustomerItemWidget({@required this.id,@required this.email,@required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(email),
      leading: Text(phoneNumber),
      trailing: Container(
        width: 100,
        child:
      Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: (){            
            Navigator.of(context).pushNamed(EditCustomerScreen.routename,arguments: id);
          },color: Theme.of(context).primaryColor,),
          IconButton(icon: Icon(Icons.delete), onPressed: (){
              Provider.of<CustomerProvider>(context,listen: false).deleteCustomer(id);
          },color: Theme.of(context).accentColor,),
        ],
      ),
      )
    );
  }
}