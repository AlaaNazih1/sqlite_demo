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
    String sql = "INSERT INTO PERSON (name, age, salary) VALUES ('${person.name}', ${person.age}, ${person.salary})";
    int result = await insert(sql);
    return result;
  }

  Future<int> updatePerson(Person person) async {
    String sql = "UPDATE PERSON SET name = '${person.name}', age = ${person.age}, salary = ${person.salary} WHERE id = ${person.id}";
    int result = await update(sql);
    return result;
  }

  Future<int> deletePerson(Person person) async {
    String sql = "DELETE FROM PERSON WHERE id = ${person.id}";
    int result = await delete(sql);
    return result;
  }
}