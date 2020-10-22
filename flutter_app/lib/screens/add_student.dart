import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {

  TextEditingController _nameController, _rollController, _numberController;
  String _typeSelected ='';

  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _rollController = TextEditingController();
    _numberController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('Info');
  }

  Widget _buildGender(String title){

    return InkWell(

      child: Container(
        height: 40,
        width: 90,

        decoration: BoxDecoration(
          color: _typeSelected == title? Colors.green : Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Center(child: Text(title, style: TextStyle(fontSize: 18,
            color: Colors.white),
        ),),),

      onTap: (){
        setState(() {
          _typeSelected = title;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Info'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _rollController,
              decoration: InputDecoration(
                hintText: 'Enter Role',
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15,),
            TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                hintText: 'Enter Mobile Number',
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildGender('Male'),
                  SizedBox(width: 10),
                  _buildGender('Female'),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(child: Text('Save Info',style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,

              ),),
                onPressed: (){
                  saveInfo();
                },

                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
  void saveInfo(){

    String name = _nameController.text;
    String roll = _rollController.text;
    String number = _numberController.text;

    Map<String,String> info = {
      'name':name,
      'roll':roll,
      'number':number,
      'gender': _typeSelected,
    };

    _ref.push().set(info).then((value) {
      Navigator.pop(context);
    });


  }
}
