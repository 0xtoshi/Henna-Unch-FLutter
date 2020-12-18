import 'package:flutter/material.dart';

import './service/api_service.dart';
import './models/profile.dart';
import './screens/add_data_screen.dart';
import './screens/edit_data_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [];
  ApiService apiService;
  BuildContext context;

  List<Profile> profiles;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    ApiService().getProfiles().then((value) {
      print('value: $value');
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Henna Unch Petshop'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDataScreen(
                      id: profiles.length,
                    ),
                  ),
                );
              })
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiService.getProfiles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child:
                    Text('Something went wrong: ${snapshot.error.toString()}'),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              profiles = snapshot.data;
              print(profiles.length);

              return _buildListView(profiles);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            title: Text('Pakan'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Obat'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.tag_faces), title: Text('Perlengkapan'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildListView(List<Profile> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          Profile profile = profiles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(profile.nama),
                    Text(profile.harga),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            print('delete');
                            apiService
                                .deleteProfile(int.parse(profile.id))
                                .then((isSuccess) {
                              if (isSuccess) {
                                setState(() {});
                                // Scaffold.of(this.context).showSnackBar(
                                //   SnackBar(
                                //     content: Text("Delete data success"),
                                //   ),
                                // );
                              } else {
                                // Scaffold.of(this.context).showSnackBar(SnackBar(
                                //     content: Text("Delete data failed")));
                                print('failed');
                              }
                            });
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onPressed: () {
                            print('Edit');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditDataScreen(
                                          id: index + 1,
                                          nama: profile.nama,
                                          harga: profile.harga,
                                          stok: profile.stok,
                                        )));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
