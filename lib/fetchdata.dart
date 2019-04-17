import 'package:flutter/material.dart';

class UserData extends StatelessWidget {

  final String Image;
  final String Name;
  final String  des;
  final String sellingitem;
  final String price;
  UserData({
    Key key, this.Image, this.Name,this.des,this.sellingitem,this.price
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
      child: Container(
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.2, 1.0),
              blurRadius: 5.0,
              color: Colors.black26,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Hero(
                tag: Image,
                child: Container(
                  width: 80.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(Image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    sellingitem,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "By:$Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(
                      des,
                      style: TextStyle(
                        color: Color(0xFFBBCCCC),
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
          Text(
            "Rs:$price",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
                  SizedBox(
                    height: 2.0,
                  ),
                ],
              ),
              Container(
                height: 70,
                width: 70,
                child: Text(
                  "Rs:$price",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}