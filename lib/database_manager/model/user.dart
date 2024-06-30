class User{
  String? id;
  String? fullName;
  String? userName;
  String? emailAddress;

  User({ this.id,  this.fullName,  this.userName, this.emailAddress});
  User.fromFireStore(Map<String, dynamic>? data):this(
    id: data?['id'],
    fullName: data?['fullName'],
    userName: data?['userName'],
    emailAddress: data?['emailAddress'],
  );
  Map<String , dynamic>toFireStore(){
    return {
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'emailAddress': emailAddress,
    };
  }



}