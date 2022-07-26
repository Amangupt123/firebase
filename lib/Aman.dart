// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Amanapp extends StatefulWidget {
  const Amanapp({super.key});

  @override
  State<Amanapp> createState() => _AmanappState();
}

class _AmanappState extends State<Amanapp> {
  var FirestoreA = FirebaseFirestore.instance.collection("rasu").snapshots();
  late TextEditingController aInputController;
  late TextEditingController bInputController;
  late TextEditingController cInputController;
  @override
  void initstate() {
    aInputController = TextEditingController();
    bInputController = TextEditingController();
    cInputController = TextEditingController();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aman"),
      ),
      body: StreamBuilder(
        stream: FirestoreA,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                return Column(
                  children: [
                    Text(snapshot.data!.docs[index].data()['a']),
                    Text(snapshot.data!.docs[index].data()['b']),
                    Text(snapshot.data!.docs[index].data()['c']),
                  ],
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.grey,
                    // elevation: 1,
                    //  actions: [Icon(Icons.message)],
                    title: TextField(
                      decoration: InputDecoration(labelText: "test"),
                      controller: aInputController,
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          FirebaseFirestore.instance.collection("rasu").add(
                              {"a": aInputController.text, "b": bInputController.text, "c": bInputController.text, "timestamp": DateTime.now()}).then((value) {
                            // print(value.documentID);
                          }).catchError((error) => print(error));
                        },
                        child: Text("save"),
                      )
                    ],
                  ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
