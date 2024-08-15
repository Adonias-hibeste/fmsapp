import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003049),
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Card(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Text(
                '  Account',
                style: TextStyle(color: Colors.black, fontSize: 23),
              ),
              ListTile(
                title: Text("profile"),
                trailing: Icon(Icons.arrow_forward),
              ),
              ListTile(
                title: Text("Notifications"),
                trailing: Icon(Icons.arrow_forward),
              ),
              Text(
                '  App Settings',
                style: TextStyle(color: Colors.black, fontSize: 23),
              ),
              ListTile(
                title: Text("Dark Mode"),
                trailing: Icon(Icons.arrow_forward),
              ),
              ListTile(
                title: Text("Language"),
                trailing: Icon(Icons.arrow_drop_down),
              ),
              ListTile(
                title: Text("Help & Support"),
                trailing: Icon(Icons.arrow_forward),
              ),
              Text(
                '  Your Data',
                style: TextStyle(color: Colors.black, fontSize: 23),
              ),
              ListTile(
                title: Text("Delete Account"),
                trailing: Icon(Icons.arrow_forward),
              )
            ])));
  }
}
