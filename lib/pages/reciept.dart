import 'package:flutter/material.dart';

class Reciept extends StatefulWidget {
  const Reciept({super.key});

  @override
  State<Reciept> createState() => _RecieptState();
}

class _RecieptState extends State<Reciept> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF003049),
          title: Text(
            "View Reciept",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
        body: Card(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                '  100 ETB',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '  you have paid for the memebership',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text("Payment ID"),
                subtitle: Text("dsfdj243"),
                trailing: Text("copy"),
              ),
              ListTile(
                title: Text("From "),
                subtitle: Text("Telebirr ***4454"),
                trailing: Icon(Icons.wallet),
              ),
              ListTile(
                title: Text("To "),
                subtitle: Text("Addis FC"),
                trailing: Icon(Icons.person),
              ),
            ])));
  }
}
