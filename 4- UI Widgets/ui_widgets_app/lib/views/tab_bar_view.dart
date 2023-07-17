import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  TabBarScreen({Key? key});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hulk\'s Tabbar Challenge'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.first_page),
              text: 'Tab 1',
            ),
            Tab(
              icon: Icon(Icons.pages),
              text: 'Tab 2',
            ),
            Tab(
              icon: Icon(Icons.padding_outlined),
              text: 'Tab 3',
            ),
            Tab(
              icon: Icon(Icons.safety_check_sharp),
              text: 'Tab 4',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text(
              'Tab 1',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              'Tab 2',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              'Tab 3',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Center(
            child: Text(
              'Tab 4',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
