import 'package:flutter/material.dart';

import '../service/api_service.dart';
import '../main.dart';
import '../models/profile.dart';

// final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

// ignore: must_be_immutable
class AddDataScreen extends StatefulWidget {
  int id;
  AddDataScreen({this.id});
  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  ApiService apiService = ApiService();

  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pakan'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                right: 10.0, top: 20.0, left: 10.0, bottom: 0.0),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Masukan Nama Barang';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration:
                                    InputDecoration(hintText: 'Nama Barang'),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Masukan Harga Barang';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration:
                                    InputDecoration(hintText: 'Harga Barang'),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: pwdController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Masukan Harga Barang';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration:
                                    InputDecoration(hintText: 'Harga Barang'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              child: Text('Add'),
                              color: Colors.green,
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  print('success');
                                  setState(() => isLoading = true);
                                  String nama = nameController.text.toString();
                                  String harga =
                                      emailController.text.toString();
                                  String stok = pwdController.text.toString();
                                  String id = "${widget.id}";
                                  Profile profile = Profile(
                                      id: id,
                                      nama: nama,
                                      harga: harga,
                                      stok: stok);
                                  apiService
                                      .createProfile(profile)
                                      .then((success) {
                                    setState(() => isLoading = false);
                                    if (success) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyApp()));
                                      nameController.clear();
                                      emailController.clear();
                                      pwdController.clear();
                                    } else {
                                      print('failed');
                                    }
                                  });
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
