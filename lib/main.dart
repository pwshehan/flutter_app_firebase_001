import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './models/book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Text('Text'),
    );
  }
}

class BookFirebaseDemo extends StatefulWidget {

  BookFirebaseDemo() : super();

  final String appTitle = "Book DB";

  @override
  _BookFirebaseDemoState createState() => _BookFirebaseDemoState();
}

class _BookFirebaseDemoState extends State<BookFirebaseDemo> {

  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookAuthorController = TextEditingController();

  bool isEditing = false;
  bool textFieldVisibility = false;
  
  String firestoreCollectionName = "Books";
  
  Book currentBook;
  
  getAllBooks(){
    return Firestore.instance.collection(firestoreCollectionName).snapshots();
  }
  
  addBook() async {
    Book book = Book(bookName: bookNameController.text, authorName: bookAuthorController.text);

    try{
      Firestore.instance.runTransaction(
          (Transaction transaction) async {
            await Firestore.instance.collection(firestoreCollectionName).document().setData(book.toJson());
          }
      );
    }catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
