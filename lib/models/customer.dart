class Customer{  
  final String id;
  final String firstName;
	final String lastName;
	final DateTime dateOfBirth;
	final String phoneNumber;
	final String email;
	final String bankAccountNumber;
  Customer({this.id,this.firstName,this.lastName,this.dateOfBirth,this.phoneNumber,this.email,this.bankAccountNumber});
  Customer.fromMap(Map<String, dynamic> res)
      : 
        id = res["id"],
        firstName = res["firstName"],
        lastName = res["lastName"],
        dateOfBirth = res["dateOfBirth"],
        email = res["email"],
        phoneNumber = res["phoneNumber"],
        bankAccountNumber = res["bankAccountNumber"];

  Map<String, Object> toMap() {
    return {'id':id,'firstName': firstName, 'lastName': lastName, 'dateOfBirth': dateOfBirth, 'email': email,'phoneNumber':phoneNumber,"bankAccountNumber":bankAccountNumber};
  }
}