import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:membermanagementsystem/constants/constants.dart';
import 'package:membermanagementsystem/controllers/api_service.dart';
import 'package:membermanagementsystem/controllers/auth_service.dart';
import 'package:membermanagementsystem/models/blogspost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:membermanagementsystem/pages/events.dart';
import 'package:membermanagementsystem/pages/mydrawer.dart';
import 'package:membermanagementsystem/pages/news.dart';
import 'package:membermanagementsystem/pages/payments.dart';
import 'package:membermanagementsystem/pages/settings.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
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
          MaterialPageRoute(builder: (context) => PaymentFormPage()),
        );
        break;
    }
  }

  late Future<List<BlogPost>> futureBlogPosts;

  @override
  void initState() {
    super.initState();
    futureBlogPosts = fetchBlogPosts();
  }

  Future<List<BlogPost>> fetchBlogPosts() async {
    final response = await http.get(
      Uri.parse(url + 'blogs'),
      headers: {
        // 'Accept': 'application/json',
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
      },
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => BlogPost.fromJson(post)).toList();
    } else {
      print('Failed to load blog posts: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load blog posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003049),
        title: Text(
          'Blogs',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.settings, color: Colors.white),
            color: Colors.white,
            onSelected: (value) {
              if (value == 'logout') {
                AuthService.logout().then((_) {
                  Get.offAllNamed('/Login');
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Logout', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: FutureBuilder<List<BlogPost>>(
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors
            .black, // Ensure selected item color is the same as unselected
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
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
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedIconTheme: IconThemeData(
          color:
              Colors.black, // Ensure the selected icon color remains the same
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
                  child: Image.network(
                    imageUrl!,
                    width: double.infinity,
                    fit: BoxFit
                        .cover, // Use BoxFit.cover to ensure the image covers the container
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
            ButtonBar(
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

                        if (comment != null && comment.isNotEmpty) {
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

                        if (comment != null && comment.isNotEmpty) {
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