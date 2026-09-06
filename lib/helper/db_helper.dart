import 'package:sqlite_demo/lite_db.dart';
import 'package:sqlite_demo/models/person.dart';

class DbHelper  extends LiteDB{
 Future<List<Person>> getAllPersons() async {
    List<Person> persons = [];
    String sql = "SELECT * FROM PERSON";
    List<Map<String, dynamic>> rows =await inQuery(sql);
    for (var element in rows) {
      persons.add(Person.fromJson(element));
    }
    return persons;
  }

 Future<int> insertNewPerson(Person person) async {
    String sql = "INSERT INTO PERSON (name, age) VALUES ('${person.name}', ${person.age})";
    int result = await insert(sql);
    return result;
  }
}