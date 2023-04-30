import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/afef/screens/Admin_Screen/firstpageadmin.dart';
import 'package:essai2/afef/screens/Emp_Screen/acceuilemp.dart';
import 'package:essai2/afef/screens/Enseignat_Screen/acceuilens.dart';
import 'package:essai2/afef/screens/Etudiant_Screen/acceuietudiant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:essai2/afef/screens/Admin_Screen/accountliststudent.dart';
import 'package:essai2/afef/screens/Admin_Screen/addaccount.dart';
import 'Admin_Screen/addaccount.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isobscure3 = true;

  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[700],
      body: ListView(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.6,
          child: Column(children: [
            Image.asset(
              'assets/images/logo.png',
              height: 150.0,
              width: 300.0,
              scale: 0.5,
            ),
            SizedBox(
              height: 50,
            ),
          ]),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(66), topRight: Radius.circular(66)),
            color: Colors.white,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Text("Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40,
                    )),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan.shade700)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Login',
                    enabled: true,
                    prefixIcon: Icon(Icons.mail),
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 40.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan.shade700),
                        borderRadius: new BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.cyan.shade700),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value?.length == 0) {
                      return "Champs obligatoire vide !";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-].[a-z]")
                        .hasMatch(value!)) {
                      return ("entrer un email valide!");
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: _isobscure3,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan.shade700)),
                    suffixIcon: IconButton(
                      color: Colors.cyan.shade700,
                      icon: Icon(_isobscure3
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isobscure3 = !_isobscure3;
                        });
                      },
                    ),
                    prefixIcon: Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Mot de passe',
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 40.0, top: 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.cyan.shade700),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.cyan.shade700),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "le mot de passe ne peut pas être vide!";
                    }
                    if (!regex.hasMatch(value)) {
                      return ("entrer un valide mot de passe! ");
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    passwordController.text = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      visible = true;
                    });
                    signIn(emailController.text, passwordController.text);
                  },
                  // style: ButtonStyle(elevation: MaterialStateProperty(12.0 )),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(60.0, 60.0),
                      backgroundColor: Colors.cyan[700],
                      elevation: 13.0,
                      textStyle: const TextStyle(color: Colors.white)),

                  child: const Text(
                    'Se Connecter',
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 250, top: 20),
                  child: InkWell(
                    child: Text(
                      "Mot de passe oublié?",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade700),
                    ),
                    onTap: () {},
                  ),
                ),
                Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: visible,
                    child: Container(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    )))
              ],
            ),
          ),
        )
      ]),
    );
  }

  /* void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        route();
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          print('pas utilisateur trouver pour ce email');
        } else if (e.code == 'wrong-password') {
          print('wrong password provided for that user');
        }
      }
    }
  }

  void route() async {
    User? user = FirebaseAuth.instance.currentUser;
    var kk =
        FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (documentSnapshot.exists) {
      if (documentSnapshot.get('urool') == "admin") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AcceuilAdmin()),
        );
      } else if (documentSnapshot.get('urool') == "enseignant") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AcceuilEns()));
      } else if (documentSnapshot.get('urool') == "employe") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AcceuilEmp()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AcceuilEtudiant()));
      }
    } else {
      print('Document existe pas dans base de donées');
    }
  }
}*/

  Future<void> signIn(email, password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();

      //Map<String, dynamic> userData = userSnapshot.data();
      if (userSnapshot.exists) {
        if (userSnapshot.get('role') == 'admin') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AcceuilAdmin()),
          );
        } else if (userSnapshot.get('role') == 'enseignant') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AcceuilEns()),
          );
        } else if (userSnapshot.get('role') == 'etudiant') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AcceuilEtudiant()),
          );
        } else if (userSnapshot.get('role') == 'employé') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AcceuilEmp()),
          );
        }
      } else {
        ('Document existe pas dans base de donées');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ('pas utilisateur trouver pour ce email');
      } else if (e.code == 'wrong-password') {
        ('wrong password provided for that user');
      }
    }
  }
}
