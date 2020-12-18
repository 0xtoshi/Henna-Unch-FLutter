import 'package:flutter/material.dart';

import '../service/api_service.dart';
import '../models/profile.dart';
import '../main.dart';

// ignore: must_be_immutable
class EditDataScreen extends StatefulWidget {
  int id;
  String nama, harga, stok;

  EditDataScreen({this.id, this.nama, this.harga, this.stok});
  @override
  _EditDataScreenState createState() => _EditDataScreenState();
}

class _EditDataScreenState extends State<EditDataScreen> {
  ApiService apiService = ApiService();

  List<EditNameField> editNameField = [];
  List<EditEmailField> editEmailField = [];
  List<EditPasswordField> editPasswordField = [];

  addEditNameField() {
    if (editNameField.length > 0) {
      return;
    }
    editNameField.add(EditNameField());
    setState(() {});
  }

  removeEditNameField(listItemIndex) {
    setState(() {});
    editNameField.removeAt(listItemIndex);
  }

  addEditEmailField() {
    if (editEmailField.length > 0) {
      return;
    }
    editEmailField.add(EditEmailField());
    setState(() {});
  }

  removeEditEmailField(listItemIndex) {
    setState(() {});
    editEmailField.removeAt(listItemIndex);
  }

  addEditPasswordField() {
    if (editPasswordField.length > 0) {
      return;
    }
    editPasswordField.add(EditPasswordField());
    setState(() {});
  }

  removeEditPasswordField(listItemIndex) {
    setState(() {});
    editPasswordField.removeAt(listItemIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit data'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            child: Card(
              elevation: 5,
              // height: 600,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: FlatButton(
                        color: Colors.blue,
                        child: Text(
                          'Edit Name',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          addEditNameField();
                        },
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: editNameField.length,
                      itemBuilder: (_, index) {
                        return Row(children: [
                          Expanded(
                            flex: 12,
                            child: editNameField[index],
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                print('removing');
                                removeEditNameField(index);
                              },
                              child: Container(
                                width: 10,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      },
                    ),
                    Container(
                      child: FlatButton(
                        color: Colors.blue,
                        child: Text(
                          'Edit Email',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          addEditEmailField();
                        },
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: editEmailField.length,
                      itemBuilder: (_, index) {
                        return Row(children: [
                          Expanded(
                            flex: 12,
                            child: editEmailField[index],
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                print('removing');
                                removeEditEmailField(index);
                              },
                              child: Container(
                                width: 10,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      },
                    ),
                    Container(
                      child: FlatButton(
                        color: Colors.blue,
                        child: Text(
                          'Edit Password',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          addEditPasswordField();
                        },
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: editPasswordField.length,
                      itemBuilder: (_, index) {
                        return Row(children: [
                          Expanded(
                            flex: 12,
                            child: editPasswordField[index],
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                print('removing');
                                removeEditPasswordField(index);
                              },
                              child: Container(
                                width: 10,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ]);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          color: Colors.green,
                          child: Text('Edit'),
                          onPressed: () {
                            print('ADD');
                            String nama = nameController.text.toString().isEmpty
                                ? widget.nama
                                : nameController.text.toString();
                            String harga =
                                emailController.text.toString().isEmpty
                                    ? widget.harga
                                    : emailController.text.toString();
                            String stok =
                                passwordController.text.toString().isEmpty
                                    ? widget.stok
                                    : passwordController.text.toString();

                            Profile profile =
                                Profile(nama: nama, harga: harga, stok: stok);
                            profile.id = "${widget.id}";
                            print(profile);
                            apiService.updateProfile(profile).then((success) {
                              print(success);
                              if (success) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
                                nameController.clear();
                                emailController.clear();
                                passwordController.clear();
                              } else {
                                print('failed');
                              }
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class EditNameField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        hintText: 'Name',
      ),
    );
  }
}

class EditEmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Email',
      ),
    );
  }
}

class EditPasswordField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
      ),
    );
  }
}
