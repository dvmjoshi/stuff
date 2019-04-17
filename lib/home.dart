import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stuff/detailpage.dart';
import 'package:stuff/fetchdata.dart';
import 'package:stuff/homepage.dart';
import 'user.dart';

class home extends StatefulWidget {
  home() : super();

  final String title = "STUFF";
  @override
  homeState createState() => homeState();
}

class homeState extends State<home> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  validateFormAndSave() {
    print("Validating Form...");
    if (_key.currentState.validate()) {
      print("Validation Successful");
      _key.currentState.save();
      print('Name ');
      print('Age ');
    } else {
      print("Validation Error");
    }
  }
  navigateDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => Detail(post:post)
    ));

  }
  String _validateData(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Please enter data";
    }
  }

  String name, email, mobile;
  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }
  //
  bool showTextField = false;
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  String collectionName = "Users";
  bool isEditing = false;
  User curUser;

  homeState();


  getUsers() {
    return Firestore.instance.collection(collectionName).snapshots();
  }

  addUser() {
    User user = User(name: controller.text,description: controller1.text,
        contactno: controller2.text,imageurl: controller3.text,
        location: controller4.text,sellingitem:controller5.text,price: controller6.text);
    try {
      Firestore.instance.runTransaction(
            (Transaction transaction) async {
          await Firestore.instance
              .collection(collectionName)
              .document()
              .setData(user.toJson());
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  add() {
    if (isEditing) {
      // Update
      update(curUser, controller.text,controller1.text,controller2.text,controller3.text,
      controller4.text,controller5.text,controller6.text);
      setState(() {
        isEditing = false;
      });
    } else {
      addUser();
    }
    controller.text = '';
  }

  update(User user, String newName, String des,String location,String imageurl,String sellingitem
      ,String  contactno,String  price) {
    try {
      Firestore.instance.runTransaction((transaction) async {
        await transaction.update(user.reference, {'name': newName,'description':des,"loaction":location,'imageurl'
            :imageurl,'sellingitem':sellingitem,'conactno':contactno,"price":price});
      });
    } catch (e) {
      print(e.toString());
    }
  }

  delete(User user) {
    Firestore.instance.runTransaction(
          (Transaction transaction) async {
        await transaction.delete(user.reference);
      },
    );
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }
        if (snapshot.hasData) {
          print("Documents ${snapshot.data.documents.length}");
          return buildList(context, snapshot.data.documents);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => buildListItem(context, data)).toList(),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final   user = User.fromSnapshot(data);

    return Column(
      children: <Widget>[
        Padding(
          key: ValueKey(user.name),
          padding: EdgeInsets.all( 8.0),
          child: Container(
            child: Column(
              children: <Widget>[
              InkWell(
                onTap:(){
                  navigateDetail(data);
                },
                onDoubleTap:(){
                  setUpdateUI(user);
                } ,
                onLongPress: ()
                {  delete(user);},
                child: UserData(
                  sellingitem: user.sellingitem,
                  Name: user.name,
                  des: user.description,
                  Image: user.imageurl,
                  price: user.price,
                ),
              ),
                /*ListTile(
                  title: Text(user.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // delete
                      delete(user);
                    },
                  ),

                  onTap: () {
                    // update
                    setUpdateUI(user);
                  },
                ),*/
              ],
            ),
          ),
        ),
      ],
    );
  }

  setUpdateUI(User user) {
    controller.text = user.name;
    setState(() {
      showTextField = true;
      isEditing = true;
      curUser = user;
    });
  }

  button() {
   return Container(
      padding: const EdgeInsets.only(top: 50.0),
      width: double.infinity,
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () {
          add();
          setState(() {
            showTextField = false;
          });
        },
        color: Color(0xFF2B65F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 12.0),
          child: Text(
            'Add Item',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // backgroundColor: Color(0xFFF9EFEB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title,style: TextStyle(color: Colors.grey),),
        leading: IconButton(
          color: Colors.grey,
            icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.of(context).pushReplacementNamed('/carry');
        }),
        actions: <Widget>[
          IconButton(
            splashColor: Colors.grey,
            icon: Icon(Icons.add_circle_outline,color: Colors.grey,),
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
              });
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            showTextField
                ? Expanded(flex:10,child:ListView(children:<Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Stuff Best Place to\nSell your product Inside Campus',
                  style: TextStyle(
                    height: 1.2,
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'We will recommended your personality based on\nyour choice to sell best resources to student.',
                  style: TextStyle(
                    color: Color(0xFFBBCCCC),
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _key,
                  autovalidate: _validate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                              labelText: "Name", hintText: "Enter name"
                          , border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller5,
                          decoration: InputDecoration(
                              labelText: "item to sell", hintText: "Enter item"
                          , border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Price", hintText: " Enter Price"
                            , border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller1,
                          maxLength: 75,
                          decoration: InputDecoration(
                              labelText: "Description", hintText: "Enter description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller3,
                          decoration: InputDecoration(
                              labelText: "Imageurl", hintText: "Enter Image url",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                        controller: controller2,
                          decoration: InputDecoration(
                              labelText: "Contact", hintText: "Enter contact no.",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),),
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: controller4,
                          decoration: InputDecoration(
                              labelText: "location", hintText: "Enter location inside campus",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)
                            ),),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      button(),
                    ],
                  ),
                ),
              ),
            ]))
                : //Container(),
            Page(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Best way to buy and sell  ',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: buildBody(context),
          )
          ],
        ),
      ),
    );
  }

}