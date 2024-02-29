import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app/login.dart';
import 'package:vendor_app/loginvendors/pen_vendor/login_pen_vendor.dart';

import '../loginvendors/pencil_vendor/login_pencil_vendor.dart';

class HomePagePencil extends StatefulWidget {
  const HomePagePencil({super.key});

  @override
  State<HomePagePencil> createState() => _HomePagePencilState();
}

class _HomePagePencilState extends State<HomePagePencil> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: const Text("Pencil Vendor"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Particulars",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: Text("Shubhash Stationary",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('shubhash')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    String inventoryLevel = '';
                    snapshot.data!.docs.forEach((DocumentSnapshot doc) {
                      inventoryLevel =
                          doc['inventory_level_pencils'].toString();
                    });
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pencil",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8.0),
                            child: Text(inventoryLevel,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      maximumSize: Size(MediaQuery.of(context).size.width, 40),
                      minimumSize: Size(MediaQuery.of(context).size.width, 40),
                      backgroundColor: Colors.red),
                  onPressed: () {
                    signout();
                  },
                  child: const Text(
                    "Log out",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const LoginPage()));
  }
}
