import "package:flutter/material.dart";

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
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
            "Blogs",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.white),
            )
          ]),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            BlogPost(
              title: 'Match Day Highlights',
              content: 'Exciting match between our team and the rivals...',
            ),
            BlogPost(
              title: 'Training Sessions',
              content:
                  'Intense training sessions preparing for the next match...',
            ),
            BlogPost(
              title: 'Team Performance',
              content: 'Check out our team\'s performance during the match...',
            ),

            // Add more BlogPost widgets here
          ],
        ),
      ),
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

class BlogPost extends StatelessWidget {
  final String title;
  final String content;

  const BlogPost({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          ListTile(
            title: Text(title),
            subtitle: Text(content),
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
              IconButton(
                icon: const Icon(Icons.comment_rounded),
                onPressed: () {
                  // Handle comment action
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
        ]));
  }
}
