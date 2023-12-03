import 'package:ef_super_comics_app/screens/comics.dart';
import 'package:ef_super_comics_app/screens/comics_favorites.dart';
import 'package:ef_super_comics_app/screens/search_comics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedTab=0;

  final List<Widget> _children=[
    const Comics(),
    const SearchComics(),
    const ComicsFavorites()
  ];

  _changeTab(int index){
    setState(() {
      _selectedTab=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Super Comics App"),
      ),
      body: _children[_selectedTab],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index)=> _changeTab(index),

        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites")
        ],
      ),
    );
  }
}