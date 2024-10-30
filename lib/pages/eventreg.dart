import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/controllers/event_controller.dart';
import 'package:membermanagementsystem/pages/blogs.dart';
import 'package:membermanagementsystem/pages/events.dart';
import 'package:membermanagementsystem/pages/news.dart';
import 'package:membermanagementsystem/pages/payments.dart';
import 'package:membermanagementsystem/pages/store.dart';

class EventRegistrationPage extends StatefulWidget {
  @override
  _EventRegistrationPageState createState() => _EventRegistrationPageState();
}

class _EventRegistrationPageState extends State<EventRegistrationPage> {
  final EventController eventController = Get.put(EventController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Blogs()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Events()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => News()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Store()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentFormPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          'Event Registration',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Register for an Event',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value) => eventController.name.value = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                onChanged: (value) => eventController.email.value = value,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                onChanged: (value) => eventController.phone.value = value,
              ),
              SizedBox(height: 16.0),
              Obx(() {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select Event',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.event),
                  ),
                  items: eventController.events.map((event) {
                    return DropdownMenuItem<String>(
                      value: event['id'].toString(),
                      child: Text(event['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      eventController.selectedEvent.value = value;
                    }
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an event';
                    }
                    return null;
                  },
                );
              }),
              SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: eventController.registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0), // Adjust the padding as needed
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors
              .black, // Ensure selected item color is the same as unselected
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Store',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Payment',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
