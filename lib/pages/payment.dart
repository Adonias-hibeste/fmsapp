import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Events Page'),
    Text('Profile Page'),
    Text('Payment Page'),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: Text(
          "Payment",
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
            SizedBox(
              height: 30,
            ),
            Text(
              '  Pay to Addis FC',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '  Select account',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text("Tele Birr(ETB)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text("Balance 2300"),
              trailing: Icon(Icons.arrow_right),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
                hintText: "0.00",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              '  Member details',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text("Name Adonias Sahile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            ListTile(
              title: Text("Position Midfielder",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
            ListTile(
              title: Text("Nationality Ethiopia",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
