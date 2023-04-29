import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:essai2/afef/screens/Admin_Screen/accountliststudent.dart';
import 'package:essai2/afef/screens/Admin_Screen/addaccount.dart';
import 'package:essai2/afef/screens/Admin_Screen/firstpageadmin.dart';
import 'package:flutter/material.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({super.key});

  @override
  State<AccountListPage> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: const Text('Liste des comptes'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AcceuilAdmin()));
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 35, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 80,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  minimumSize: const Size(60.0, 60.0),
                  backgroundColor: Colors.cyan[50],
                  elevation: 10.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AccountListScreen(role: 'admin')),
                  );
                },
                child: const Text('Comptes administrateurs',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal)),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 80,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  minimumSize: const Size(60.0, 60.0),
                  backgroundColor: Colors.cyan[50],
                  elevation: 10.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AccountListScreen(role: 'enseignant')),
                  );
                },
                child: const Text('Comptes enseignants',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal)),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 80,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  minimumSize: const Size(60.0, 60.0),
                  backgroundColor: Colors.cyan[50],
                  elevation: 10.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountStudentList()),
                  );
                },
                child: const Text('Comptes étudiants',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal)),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            SizedBox(
              height: 80,
              width: 400,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                  minimumSize: const Size(60.0, 60.0),
                  backgroundColor: Colors.cyan[50],
                  elevation: 10.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AccountListScreen(role: 'employé')),
                  );
                },
                child: const Text('Comptes employés',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountListScreen extends StatelessWidget {
  final String role;

  const AccountListScreen({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text('Comptes des  $role '),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: role)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.only(top: 15, right: 9.3, left: 9.3),
                elevation: 7.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  tileColor: Colors.cyan[50],
                  title: Text(documents[index]['name']),
                  subtitle: Text(documents[index]['email']),
                  trailing: IconButton(
                    color: Colors.cyan[700],
                    icon: Icon(Icons.edit),
                    onPressed: () async {},
                  ),
                  onTap: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EmployesDetailsPage(employe: data),
                        ));*/
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()));
        },
        backgroundColor: Colors.cyan[700],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
