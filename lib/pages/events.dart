import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/models/eventspost.dart';
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/pages/blogs.dart';
import 'dart:convert';

import 'package:membermanagementsystem/pages/eventreg.dart';
import 'package:membermanagementsystem/pages/news.dart';
import 'package:membermanagementsystem/pages/payments.dart';
import 'package:membermanagementsystem/pages/store.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
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

  late Future<List<EventsPost>> futureEventsPosts;

  @override
  void initState() {
    super.initState();
    futureEventsPosts = fetchEventsPosts();
  }

  Future<List<EventsPost>> fetchEventsPosts() async {
    try {
      final response = await http.get(Uri.parse(url + 'events'));

      if (response.statusCode == 200) {
        print('Response data: ${response.body}');
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((events) => EventsPost.fromJson(events))
            .toList();
      } else {
        print('Failed to load Event posts: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load Event posts');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load Event posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          "Events",
          style: TextStyle(color: Colors.white),
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed('/Settings');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<EventsPost>>(
        future: futureEventsPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Event posts found'));
          } else {
            return ListView(
              padding: const EdgeInsets.all(10),
              children: snapshot.data!.map((events) {
                return EventsPostWidget(
                  name: events.name,
                  description: events.description,
                  imageUrl: events.imageUrl,
                );
              }).toList(),
            );
          }
        },
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

class EventsPostWidget extends StatelessWidget {
  final String? name;
  final String? description;
  final String? imageUrl;

  const EventsPostWidget({
    super.key,
    this.name,
    this.description,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventsDetailPage(
              title: name ?? 'No Title',
              description: description ?? 'No Description',
              imageUrl: imageUrl ?? '',
            ),
          ),
        );
      },
      child: Card(
        color: Color(0xFFEFEFEF),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (imageUrl != null && imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: AspectRatio(
                  aspectRatio: 20 / 20, // Adjust the aspect ratio as needed
                  child: Image.network(imageUrl!,
                      width: double.infinity, fit: BoxFit.fill
                      // Use BoxFit.cover to ensure the image covers the container
                      ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(
                  name ?? 'No Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text(
                  description ?? 'No Description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => EventRegistrationPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800, // Blue color
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () async {
                        String? comment = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController commentController =
                                TextEditingController();
                            return AlertDialog(
                              title: Text(
                                'Enter your comment',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              content: TextField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: "Comment",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                maxLines: 3,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(commentController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade800,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EventsDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const EventsDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (imageUrl.isNotEmpty)
                    Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => EventRegistrationPage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800, // Blue color
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 20), // Add spacing between icons
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () async {
                        String? comment = await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController commentController =
                                TextEditingController();
                            return AlertDialog(
                              title: Text(
                                'Enter your comment',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade800,
                                ),
                              ),
                              content: TextField(
                                controller: commentController,
                                decoration: InputDecoration(
                                  hintText: "Comment",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                maxLines: 3,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(commentController.text);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade800,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 20), // Add spacing between icons
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    // Handle share action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
