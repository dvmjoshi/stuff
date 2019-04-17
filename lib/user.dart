import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String description;
  String location;
  String contactno;
  String sellingitem;
  String imageurl;
  String price;
  DocumentReference reference;

  User({this.name,this.description,this.contactno,this.location,this.reference,
    this.sellingitem,this.imageurl,this.price});
  User.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map["name"];
    description=map["description"];
    location=map["location"];
    contactno=map["contactno"];
    sellingitem=map["sellingitem"];
    imageurl=map["imageurl"];
    price =map["price"];
  }

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  toJson() {
    return {'name': name,'description':description,"loaction":location,'imageurl'
        :imageurl,'sellingitem':sellingitem,'conactno':contactno,"price":price};
  }
}