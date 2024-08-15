import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void save() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003049),
          title: Text(
            "Profile",
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
        body: SafeArea(
            child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Image.asset(
                    "lib/images/personicon.png",
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '  Information',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Name"),
                      subtitle: Text("Adonias"),
                      trailing: Icon(Icons.edit),
                    ),
                    ListTile(
                      leading: Icon(Icons.mail),
                      title: Text("Email"),
                      subtitle: Text("adonias@gmail.com"),
                      trailing: Icon(Icons.edit),
                    ),
                    Text(
                      '  Stats',
                      style: TextStyle(color: Colors.black, fontSize: 23),
                    ),
                    ListTile(
                      leading: Icon(Icons.workspace_premium),
                      title: Text("Membership level"),
                      subtitle: Text("premium"),
                      trailing: Icon(Icons.edit),
                    ),
                    ListTile(
                      leading: Icon(Icons.numbers),
                      title: Text("Games Played"),
                      subtitle: Text("3"),
                    ),
                    ListTile(
                      leading: Icon(Icons.sports_soccer),
                      title: Text("Goals"),
                      subtitle: Text("2"),
                    ),
                    // ListTile(
                    //   title: Text("Assists"),
                    //   subtitle: Text("4"),
                    // ),
                    GestureDetector(
                        onTap: save,
                        child: Container(
                          padding: EdgeInsets.all(25),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )),
                        )),
                  ]),
            ),
          ]),
        )));
  }
}
