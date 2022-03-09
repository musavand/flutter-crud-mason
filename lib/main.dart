import 'package:flutter/material.dart';
import 'screens/edit_customer_screen.dart';
import 'screens/customer_overview_screen.dart';
import 'package:provider/provider.dart';
import 'providers/customer_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    //2-add ChangeNotifierProvider wrapper to application
    //this cause to inject provider to app childs
    //change for multi provider ChangeNotifierProvider(
    //change for multi provider create :  (ctx) => ProductsProvider(),
    MultiProvider(providers: [
       ChangeNotifierProvider(
         create : (ctx) => CustomerProvider(),
       ),
       
    ],
    child:   
    MaterialApp(
      title: 'CRUD App Demo',
     
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        accentColor : Colors.deepOrange,
        iconTheme:IconThemeData(
          color: Colors.amber,
          opacity: 20,
          size: 60,
       
          )
        //fontFamily: 'ANasr',
        
      ),
      home: CustomerOverviewScreen(),
      //b- use routeName in main screen for navigation
      routes: {
        //we must remove title param from constructor of ProductDetailScreen
        //for passing data to ProductDetailScreen we must use arguments
        EditCustomerScreen.routename : (ctx) => EditCustomerScreen(),
        
      },
    ),
    )
    ;
  }
}

