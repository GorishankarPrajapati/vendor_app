import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/home_page_book.dart';
import '../../login.dart';
import '../../register_vendors/book_vendor_register.dart';

class VendorBooklogin extends StatefulWidget {
  const VendorBooklogin({super.key});

  @override
  State<VendorBooklogin> createState() => _VendorBookloginState();
}

class _VendorBookloginState extends State<VendorBooklogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  Future signin(String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const HomePageBook()));

      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login sucessfully")));
    } catch (e) {
      return e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/469.jpg"),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Login as book vendor!',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        hintText: "Email Address"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter email address";
                      } else if (!value.contains("@")) {
                        return "Invalid email address";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey.shade300)),
                        hintText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter password";
                      } else if (value.length < 8) {
                        return "Enter minimum 8 digit password";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('New here ?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const BookRegisterPage()));
                          },
                          child: const Text("Register")),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: Text(
                          "or",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage()));
                          },
                          child: const Text("Login as other vendor")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.red,
                          maximumSize:
                              Size(MediaQuery.of(context).size.width, 40),
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 40)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signin(_email.text, _password.text);
                        }
                      },
                      child: _isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : const Text("Login")),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
