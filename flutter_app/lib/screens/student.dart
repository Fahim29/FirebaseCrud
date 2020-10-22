import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/add_student.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {

  Query _ref;

  @override
  void initState() {

    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('Info')
        .orderByChild('name');
  }

  Widget _buildInfoItem({Map info}) {
    Color typeColor = getTypeColor(info['type']);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 100,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                info['name'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.looks_one,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                info['roll'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.phone_iphone,
                color: Theme.of(context).accentColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                info['number'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 15),
              Icon(
                Icons.accessibility,
                color: typeColor,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                info['gender'],
                style: TextStyle(
                    fontSize: 16,
                    color: typeColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map info = snapshot.value;
            return _buildInfoItem(info: info);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (_){
          return AddStudent();
          },
        ));
      },
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Male') {
      color = Colors.blue;
    }

    if (type == 'Female') {
      color = Colors.pink;
    }
    return color;
  }
}
