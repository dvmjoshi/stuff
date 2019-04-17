import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';


class Page extends StatefulWidget {
  @override
  _FlutterPageState createState() => _FlutterPageState();
}

class _FlutterPageState extends State<Page> with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation      animation;
  @override
  void initState(){
    animationController =new AnimationController(duration: Duration(seconds: 10),vsync: this);
    animation=IntTween(begin: 0,end:photos.length-1 ).animate(animationController)
    ..addListener((){
      setState(() {
        photoindex=animation.value;
      });
    });
    animationController.repeat();
  }
  @override
  void dispose()
  {
    super.dispose();
    animationController.dispose();
  }
  int photoindex=0;
  List<String>photos=[
    "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80"
    "https://images.unsplash.com/photo-1554624219-4754a2ded336?ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
    "https://images.unsplash.com/photo-1553531768-c85fc0f7033f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80",
    "https://images.unsplash.com/photo-1554567369-e8f5ca406ab4?ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
    "https://images.unsplash.com/photo-1517842645767-c639042777db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80"



  ];
  void _previousImage() {
    setState(() {
      photoindex = photoindex > 0 ? photoindex - 1 : 0;
    });
  }

  void _nextImage() {
    setState(() {
      photoindex = photoindex < photos.length - 1 ? photoindex + 1 : photoindex;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: ListView(
       shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 210.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(photos[photoindex]),
                        fit: BoxFit.cover)),
              ),

            /*  GestureDetector(
                child: Container(
                  height: 210.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                onTap: _nextImage,
              ),
              GestureDetector(
                child: Container(
                  height: 210.0,
                  width: MediaQuery.of(context).size.width / 2,
                  color: Colors.transparent,
                ),
                onTap: _previousImage,
              ),*/
              Positioned(
                top: 180.0,
                left: 5.0,
                child: Row(
                  children: <Widget>[

                    SizedBox(width: 2.0),
                    Text(
                      'Stuff by dvm',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 4.0),
                    SelectedPhoto(
                        photoIndex: photoindex, numberOfDots: photos.length)
                  ],
                ),
              ),


            ],

          ),

          SizedBox(height: 2.0,),

        ],

      ),
    );

  }

}
class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return new Container(
        child: new Padding(
          padding: const EdgeInsets.only(left: 3.0, right: 3.0),
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
          ),
        ));
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];

    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
