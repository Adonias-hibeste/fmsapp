import 'package:flutter/material.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
          "Upcoming for you",
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              '  Tomorrow',
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
            ListTile(
              title: Text("Charity Match Announcement",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(
                  "We are excited to announce a charity match against our local rivals. All proceeds will go to support community sports programs. Come out and show your support for a great cause!"),
              trailing: Icon(Icons.notification_add),
            ),
            Text(
              '  Wednesday',
              style: TextStyle(color: Colors.black, fontSize: 23),
            ),
            ListTile(
              title: Text("New Kit Unveiling",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(
                  "Get ready for the big reveal! Our new team kits will be unveiled at a special event next Friday. Be the first to see the new design and get your hands on the latest gear."),
              trailing: Icon(Icons.notification_add),
            ),
            ListTile(
              title: Text("Player of the Month",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              subtitle: Text(
                  "Congratulations to our Player of the Month, Alex Johnson! Alex has shown exceptional performance and dedication on the field. Keep up the great work!"),
              trailing: Icon(Icons.notification_add),
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
