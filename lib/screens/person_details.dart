import 'package:flutter/material.dart';
import 'package:sqlite_demo/models/person.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.person.name;
    ageController.text = widget.person.age.toString();

    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text(widget.person.name),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            moveToLastScreen();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 15.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    icon: Icon(Icons.title),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 15.0),
                child: TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'age',
                    icon: Icon(Icons.apps_outage_outlined),
                  ),
                ),
              ),
              // Fourth Element
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(color: Colors.white),
                          padding: const EdgeInsets.all(8.0)
                        ) ,
                        child: const Text( 'Save',textScaleFactor: 1.5,),
                        onPressed: () {

                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(color: Colors.white),
                            padding: const EdgeInsets.all(8.0)
                        ) ,
                        child: const Text( 'Delete',textScaleFactor: 1.5,),
                        onPressed: () {

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }
}
