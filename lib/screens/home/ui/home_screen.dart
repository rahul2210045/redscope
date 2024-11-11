import 'package:flutter/material.dart';
import 'package:redscope_assignment/constant/constant.dart';
import 'package:redscope_assignment/screens/bookmark/ui/Bookmark_Screen.dart';
import 'package:redscope_assignment/screens/gallery/ui/Gallery_Screen.dart';
import 'package:redscope_assignment/screens/repo/ui/Repo_List_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    RepoListScreen(),
    GalleryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A90E2), Color(0xFF56CCF2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            "Flutter App",
            style: headingH1.copyWith(
              fontSize: screenWidth * 0.05,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
                size: screenWidth * 0.07,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookmarkScreen()),
                );
              },
            ),
          ],
        ),
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF4A90E2),
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.code, size: screenWidth * 0.07),
              label: "Repos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo, size: screenWidth * 0.07),
              label: "Gallery",
            ),
          ],
        ),
      ),
    );
  }
}
