import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:membermanagementsystem/constants/constants.dart';

import 'package:membermanagementsystem/models/blogspost.dart';
import 'package:http/http.dart' as http;
import 'package:membermanagementsystem/pages/drawer.dart';
import 'dart:convert';

import 'package:membermanagementsystem/pages/events.dart';

import 'package:membermanagementsystem/pages/news.dart';
import 'package:membermanagementsystem/pages/payments.dart';
import 'package:membermanagementsystem/pages/store.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  int _selectedIndex = 0;

  late Future<List<BlogPost>> futureBlogPosts;

  @override
  void initState() {
    super.initState();
    futureBlogPosts = fetchBlogPosts();
    _setStatusBarColor();
  }

  void _setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF003049), // Set the status bar color
      statusBarIconBrightness:
          Brightness.light, // Set the status bar icon color
    ));
  }

  Future<List<BlogPost>> fetchBlogPosts() async {
    final response = await http.get(
      Uri.parse(url + 'blogs'),
      headers: {
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => BlogPost.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Blogs()),
        ).then((_) => _setStatusBarColor());
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Events()),
        ).then((_) => _setStatusBarColor());
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => News()),
        ).then((_) => _setStatusBarColor());
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Store()),
        ).then((_) => _setStatusBarColor());
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PaymentFormPage()),
        ).then((_) => _setStatusBarColor());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Drawerscreen(), // Add the Drawerscreen here
          AnimatedContainer(
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(isDrawerOpen ? 0.85 : 1.00)
              ..rotateZ(isDrawerOpen ? -50 : 0),
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: isDrawerOpen
                  ? BorderRadius.circular(40)
                  : BorderRadius.circular(0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  color: Color(0xFF003049),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 5,
                    right: 5,
                    bottom: 5,
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isDrawerOpen) {
                              xOffset = 0;
                              yOffset = 0;
                              isDrawerOpen = false;
                            } else {
                              xOffset = 290;
                              yOffset = 80;
                              isDrawerOpen = true;
                            }
                          });
                        },
                      ),
                      Spacer(),
                      Text(
                        'Blogs',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Spacer(),
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
                ),
                Expanded(
                  child: FutureBuilder<List<BlogPost>>(
                    future: futureBlogPosts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No blog posts found'));
                      } else {
                        return ListView(
                          padding: const EdgeInsets.all(10),
                          children: snapshot.data!.map((post) {
                            return BlogPostWidget(
                              name: post.name,
                              description: post.description,
                              imageUrl: post.imageUrl,
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
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

Future<bool> submitComment(String comment) async {
  try {
    final response = await http.post(
      Uri.parse('your_api_endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your_access_token',
      },
      body: jsonEncode({'comment': comment}),
    );

    if (response.statusCode == 200) {
      print('Comment submitted: ${response.body}');
      return true;
    } else {
      print('Failed to submit comment: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error submitting comment: $e');
    return false;
  }
}

class BlogPostWidget extends StatelessWidget {
  final String? name;
  final String? description;
  final String? imageUrl;

  const BlogPostWidget({
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
            builder: (context) => BlogDetailPage(
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
                  aspectRatio: 1, // 1:1 aspect ratio for a square image
                  child: Image.network(
                    imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.fill, // Set a fixed height for the image
                    // Ensure the image covers the container
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
                IconButton(
                  icon: const Icon(Icons.thumb_up),
                  onPressed: () {
                    // Handle like action
                  },
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
                                  color: Color(0xFF003049),
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
                                    backgroundColor: Color(0xFF003049),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (comment!.isNotEmpty) {
                          // Handle the comment here
                          print('Comment: $comment');

                          // Simulate API call to submit the comment
                          bool isSuccess = await submitComment(comment);

                          if (isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Comment submitted successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to submit comment.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          print('No comment entered');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No comment entered.'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
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

class BlogDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const BlogDetailPage({
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
        backgroundColor: Color(0xFF003049),
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
                IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () {
                    // Handle like action
                  },
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
                                  color: Color(0xFF003049),
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
                                    backgroundColor: Color(0xFF003049),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (comment!.isNotEmpty) {
                          // Handle the comment here
                          print('Comment: $comment');

                          // Simulate API call to submit the comment
                          bool isSuccess = await submitComment(comment);

                          if (isSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Comment submitted successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to submit comment.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          print('No comment entered');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No comment entered.'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
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

  Future<bool> submitComment(String comment) async {
    try {
      final response = await http.post(
        Uri.parse('your_api_endpoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_access_token',
        },
        body: jsonEncode({'comment': comment}),
      );

      if (response.statusCode == 200) {
        print('Comment submitted: ${response.body}');
        return true;
      } else {
        print('Failed to submit comment: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error submitting comment: $e');
      return false;
    }
  }
}
