import 'package:flutter/material.dart';
import 'package:sqlite_demo/models/person.dart';
import 'package:sqlite_demo/screens/person_details.dart';

class PersonsList extends StatefulWidget {
  const PersonsList({Key? key}) : super(key: key);

  @override
  State<PersonsList> createState() => _PersonsListState();
}

class _PersonsListState extends State<PersonsList> {

  List<Person>? personList;
  int count = 0;

  void updateListView() {
    personList = [];
    personList?.add(Person(id: 1, name: 'Ahmed', age: 30));
    personList?.add(Person(id: 2, name: 'Mohamed', age: 31));
    personList?.add(Person(id: 3, name: 'Salah', age: 32));
  }

  @override
  Widget build(BuildContext context) {
    if (personList == null) {
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Persons App", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
        onPressed: () {
          navigateToDetail(Person.getNewEmpty());
        },
      ),
    );
  }

  ListView getNoteListView(){
    return ListView.builder(
      itemCount: personList!.length,
      itemBuilder: (context, position){
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.deepPurple,
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
                child: Image.asset('assets/person.png'),
            ),
            title: Text(personList![position].name,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
              ),
            ),
            subtitle: Text(personList![position].age.toString(),
              style: const TextStyle(
                  color: Colors.white
              ),
            ),
            trailing: GestureDetector(
              child: const Icon(Icons.info, color: Colors.white,),
              onTap: (){
                navigateToDetail(personList![position]);
              },
            ),
          ),
        );
      },
    );
  }

  void navigateToDetail(Person person) async{
    bool result = await Navigator.push(context, MaterialPageRoute(
        builder: (context){
          return PersonDetails(person: person);
        }
    ));
    if(result == true){
      updateListView();
    }else if(result == false){
      const Text("No Notes to Show");
    }
  }
}
