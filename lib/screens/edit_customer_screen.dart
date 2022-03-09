import 'package:flutter/material.dart';
import '../widgets/appdrawer_widget.dart';
import '../models/customer.dart';
import 'package:provider/provider.dart';
import '../providers/customer_provider.dart';
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';

class EditCustomerScreen extends StatefulWidget {
 
  static const String  routename='/edit_customer';

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
extension PhoneNumberValidator on String {
  bool isValidPhoneNumber() {
    return RegExp(
            r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$')
        .hasMatch(this);
  }
}
class _EditCustomerScreenState extends State<EditCustomerScreen> {

  
  final _phoneNumberFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _bankAccountNumberFocusNode = FocusNode();
  final _dateOfBirthFocusNode = FocusNode();
   final _dateOfBirthControler = TextEditingController();
  
  final _form =GlobalKey<FormState>();
  var _editedCustomer = Customer(
    id: null,
    firstName: '',
    lastName: '',
    dateOfBirth: DateTime.now(),
    phoneNumber: '',
    email: '',
    bankAccountNumber: ''
  
    );
   var _initValue={
      'firstName': '',
      'lastName': '',
      'dateOfBirth': DateTime.now(),
      'phoneNumber': '',
      'email': '',
      'bankAccountNumber': ''
   };
   var _isInit=false;

  
 
 
 @override
 void initState(){   
   super.initState();
 }
 @override
 void didChangeDependencies(){
   if(!_isInit){
     
     
     final String customerId=ModalRoute.of(context).settings.arguments as String;
     if(customerId !=null){
     _editedCustomer=Provider.of<CustomerProvider>(context).findById(customerId);
     _initValue={
      'firstName': _editedCustomer.firstName,
      'lastName': _editedCustomer.lastName,
      'dateOfBirth':_editedCustomer.dateOfBirth,
      'phoneNumber': _editedCustomer.phoneNumber,
      'email': _editedCustomer.email,
      'bankAccountNumber': _editedCustomer.bankAccountNumber
      
   };
    _dateOfBirthControler.text=_editedCustomer.dateOfBirth.toString();
     }
     
   }
   _isInit=false;
   super.didChangeDependencies();
 }

 @override
 void dispose(){
   _dateOfBirthControler.dispose();
   _phoneNumberFocusNode.dispose();
   _firstNameFocusNode.dispose();
   _lastNameFocusNode.dispose();
   _bankAccountNumberFocusNode.dispose();
   _dateOfBirthFocusNode.dispose();
   super.dispose();
 }
  void _saveForm()
  {
    final isValid=_form.currentState.validate();
    if (!isValid)
      return;
    _form.currentState.save();
    if(_editedCustomer.id!=null)
       Provider.of<CustomerProvider>(context,listen: false).updateCustomer(_editedCustomer.id, _editedCustomer);
    else
       Provider.of<CustomerProvider>(context,listen: false).addCustomer(_editedCustomer);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer  Data'),
        actions: [ IconButton(icon: Icon(Icons.save), onPressed: _saveForm) ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(6.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValue['email'],
                decoration: InputDecoration(labelText: 'email'),
                textInputAction: TextInputAction.next,
                
                onFieldSubmitted: (_){
                    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
                },
                autovalidate: true,
                validator: (input) => input.isValidEmail() ? null : "Check your email",
                onSaved: (value){
                  //assert(EmailValidator.validate(value));
                  _editedCustomer=Customer(
                    id: _editedCustomer.id,                    
                    email: value,
                    phoneNumber: _editedCustomer.phoneNumber,
                    firstName: _editedCustomer.firstName,                    
                    lastName: _editedCustomer.lastName, 
                    bankAccountNumber: _editedCustomer.bankAccountNumber, 
                    dateOfBirth: _editedCustomer.dateOfBirth
                    );
                },
              ),
               TextFormField(
                initialValue: _initValue['phoneNumber'],
                decoration: InputDecoration(labelText: 'Phone Number'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _phoneNumberFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_firstNameFocusNode);
                },
                autovalidate: true,
                validator: (val) => val.isValidPhoneNumber() ? null : "Check your phone number",
                 onSaved: (value){
                  _editedCustomer=Customer(
                   
                    id: _editedCustomer.id,                    
                    email: _editedCustomer.email,
                    phoneNumber: value,
                    firstName: _editedCustomer.firstName,                    
                    lastName: _editedCustomer.lastName, 
                    bankAccountNumber: _editedCustomer.bankAccountNumber, 
                    dateOfBirth: _editedCustomer.dateOfBirth
                    );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                textInputAction: TextInputAction.next,
                initialValue: _initValue['firstName'],
                focusNode: _firstNameFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_lastNameFocusNode);
                },
                validator: (val){
                  if (val.isEmpty){
                    return 'Please Enter First Name.';
                  } 
                  
                  return null;
                },
                onSaved: (value){
                  _editedCustomer=Customer(
                   
                    id: _editedCustomer.id,                    
                    email: _editedCustomer.email,
                    phoneNumber: _editedCustomer.phoneNumber,
                    firstName: value,                    
                    lastName: _editedCustomer.lastName, 
                    bankAccountNumber: _editedCustomer.bankAccountNumber, 
                    dateOfBirth: _editedCustomer.dateOfBirth
                    );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                textInputAction: TextInputAction.next,
                initialValue: _initValue['lastName'],
                focusNode: _lastNameFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_bankAccountNumberFocusNode);
                },
                validator: (val){
                  if (val.isEmpty){
                    return 'Please Enter Last Name.';
                  } 
                  
                  return null;
                },
                onSaved: (value){
                  _editedCustomer=Customer(
                   
                    id: _editedCustomer.id,                    
                    email: _editedCustomer.email,
                    phoneNumber: _editedCustomer.phoneNumber,
                    firstName: _editedCustomer.firstName,                    
                    lastName: value, 
                    bankAccountNumber: _editedCustomer.bankAccountNumber, 
                    dateOfBirth: _editedCustomer.dateOfBirth
                    );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Bank Acount Number'),
                textInputAction: TextInputAction.next,
                initialValue: _initValue['bankAccountNumber'],
                focusNode: _bankAccountNumberFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_dateOfBirthFocusNode);
                },
                validator: (val){
                  if (val.isEmpty){
                    return 'Please Enter Bank Acount Number.';
                  } 
                  
                  return null;
                },
                onSaved: (value){
                  _editedCustomer=Customer(
                   
                    id: _editedCustomer.id,                    
                    email: _editedCustomer.email,
                    phoneNumber: _editedCustomer.phoneNumber,
                    firstName: _editedCustomer.firstName,                    
                    lastName: _editedCustomer.lastName, 
                    bankAccountNumber: value, 
                    dateOfBirth: _editedCustomer.dateOfBirth
                    );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date Of Birth'),
                readOnly: true,
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateOfBirthControler.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                textInputAction: TextInputAction.next,
                controller: _dateOfBirthControler,
                //initialValue: _initValue['dateOfBirth'],
                keyboardType: TextInputType.datetime,
                focusNode: _dateOfBirthFocusNode,
                onFieldSubmitted: (_){
                  //FocusScope.of(context).requestFocus(_bankAccountNumberFocusNode);
                  _saveForm();
                },
                validator: (val){
                  if (val.isEmpty){
                    return 'Please Enter Date Of Birth.';
                  } 
                  
                  return null;
                },
                onSaved: (value){
                  _editedCustomer=Customer(
                   
                    id: _editedCustomer.id,                    
                    email: _editedCustomer.email,
                    phoneNumber: _editedCustomer.phoneNumber,
                    firstName: _editedCustomer.firstName,                    
                    lastName: _editedCustomer.lastName, 
                    bankAccountNumber: _editedCustomer.bankAccountNumber, 
                    dateOfBirth: DateTime.parse(value)
                    );
                },
              ),
           ],
          )),
      ),
    );
  }
}