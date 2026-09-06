class Person {
  final int id;
  String name;
  int age;
  double salary;

  Person({required this.id, required this.name, required this.age,this.salary = 0.0});

  factory Person.getNewEmpty() {
    return Person(id: 0, name: '', age: 0, salary: 0.0);
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
     salary: (json['salary'] ?? 0.0).toDouble(),
    );
  }
}
