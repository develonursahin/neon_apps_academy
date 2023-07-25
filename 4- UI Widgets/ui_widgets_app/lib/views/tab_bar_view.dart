import 'package:flutter/material.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color _appBarColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _appBarColor = Colors.blue;
          break;
        case 1:
          _appBarColor = Colors.green;
          break;
        case 2:
          _appBarColor = Colors.red;
          break;
        case 3:
          _appBarColor = Colors.purple;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hulk\'s Tabbar Challenge'),
        backgroundColor: _appBarColor,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
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
        children: const [
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
