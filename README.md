# 🗃️ SQLite Demo — Flutter CRUD App

A simple Flutter application demonstrating how to integrate **SQLite** into a Flutter app using the `sqflite` package.

The project implements a complete **CRUD workflow** for managing people, including:

* 👤 Person name
* 🎂 Age
* 💰 Salary
* ➕ Add a person
* ✏️ Update a person
* 🗑️ Delete a person
* 📋 Display all people
* 🔄 SQLite database migration

---

## 📱 Project Overview

This project was created to practice working with local databases in Flutter and understand how to structure database-related code instead of putting everything inside the UI.

The application allows the user to:

1. View all people stored in SQLite.
2. Add a new person.
3. Edit an existing person.
4. Delete a person.
5. Persist all data locally using SQLite.

---

## 🛠️ Technologies Used

* **Flutter**
* **Dart**
* **SQLite**
* **sqflite**
* **path**

---

## 🏗️ Project Architecture

The project separates responsibilities into different layers:

```text
lib/
│
├── main.dart
│
├── models/
│   └── person.dart
│
├── helper/
│   └── db_helper.dart
│
├── screens/
│   ├── persons_list.dart
│   └── person_details.dart
│
└── lite_db.dart
```

### 📌 `main.dart`

The entry point of the application.

It launches the Flutter application and displays the `PersonsList` screen.

---

### 📌 `models/person.dart`

Contains the `Person` model.

The model represents a person with:

```text
id
name
age
salary
```

It also contains:

* A constructor
* A factory for creating an empty person
* A `fromJson` factory for converting SQLite rows into `Person` objects

---

### 📌 `screens/persons_list.dart`

Responsible for displaying all people stored in the database.

Main responsibilities:

* Loading people from SQLite
* Displaying the list
* Navigating to the details screen
* Refreshing the list after adding, updating, or deleting a person

---

### 📌 `screens/person_details.dart`

Responsible for adding and editing people.

The screen contains input fields for:

* Name
* Age
* Salary

The same screen is used for both:

```text
Add Person
     ↓
PersonDetails
```

and:

```text
Edit Person
     ↓
PersonDetails
```

The application checks the person's `id` to determine whether the operation is an **INSERT** or **UPDATE**.

---

### 📌 `helper/db_helper.dart`

Acts as a helper layer between the UI and the database.

It provides methods for:

```text
getAllPersons()
insertNewPerson()
updatePerson()
deletePerson()
```

This keeps database queries separate from the UI code.

---

### 📌 `lite_db.dart`

Responsible for the SQLite database itself.

It handles:

* Opening the database
* Creating tables
* Database versioning
* Database upgrades
* Raw SQL operations

The database contains:

### PERSON

```sql
CREATE TABLE PERSON (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  age INTEGER,
  salary REAL DEFAULT 0.0
);
```

### ACCOUNT

```sql
CREATE TABLE ACCOUNT (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  PERSON_ID INTEGER NOT NULL,
  ACCOUNT INTEGER NOT NULL,
  VALUE REAL
);
```

---

## 🔄 CRUD Operations

### Create

A new person is inserted into the `PERSON` table:

```sql
INSERT INTO PERSON (name, age, salary)
VALUES ('Alaa', 21, 0.0);
```

### Read

All people are retrieved using:

```sql
SELECT * FROM PERSON;
```

### Update

An existing person can be modified using:

```sql
UPDATE PERSON
SET name = 'Alaa',
    age = 21,
    salary = 5000
WHERE id = 1;
```

### Delete

A person can be removed using:

```sql
DELETE FROM PERSON
WHERE id = 1;
```

---

## 🧩 Database Migration

One of the important concepts demonstrated in this project is **SQLite database migration**.

Initially, the `PERSON` table did not contain a `salary` column.

When the database structure changed, the database version was increased:

```dart
version: 2
```

Then `onUpgrade` was used to add the new column:

```sql
ALTER TABLE PERSON
ADD COLUMN salary REAL DEFAULT 0.0;
```

This allows existing databases to be upgraded without deleting the user's existing data.

---

## 🔁 Application Flow

### Add Person

```text
PersonsList
    │
    │ Press +
    ▼
PersonDetails
    │
    │ Enter Name / Age / Salary
    ▼
Save
    │
    ▼
INSERT INTO PERSON
    │
    ▼
Navigator.pop(context, true)
    │
    ▼
PersonsList
    │
    ▼
Refresh List
```

### Edit Person

```text
PersonsList
    │
    │ Select Person
    ▼
PersonDetails
    │
    │ Modify Data
    ▼
Save
    │
    ▼
UPDATE PERSON
    │
    ▼
Refresh List
```

### Delete Person

```text
PersonsList
    │
    ▼
PersonDetails
    │
    ▼
Delete
    │
    ▼
DELETE FROM PERSON
    │
    ▼
Return to List
    │
    ▼
Refresh List
```

---

## 📦 Dependencies

Add the following packages to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  sqflite: ^2.4.2
  path: ^1.9.1
```

> Package versions may vary depending on the Flutter environment.

---

## 🎯 Learning Objectives

This project demonstrates the fundamentals of:

* SQLite in Flutter
* Local data persistence
* `sqflite`
* Raw SQL queries
* CRUD operations
* Database versioning
* Database migration
* Model classes
* Separation of database and UI responsibilities
* Navigation and returning data between screens
* Refreshing UI after database operations




