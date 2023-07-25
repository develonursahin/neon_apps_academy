import 'package:flutter/material.dart';

class ScrollScreen extends StatefulWidget {
  const ScrollScreen({Key? key}) : super(key: key);
  @override
  State<ScrollScreen> createState() => _ScrollScreenState();
}

class _ScrollScreenState extends State<ScrollScreen> {
  List<String> data = [
    'Spell 1',
    'Spell 2',
    'Spell 3',
    'Spell 4',
  ];

  ScrollController _scrollController = ScrollController();
  bool isEndOfList = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        isEndOfList = true;
      });
    }
  }

  void loadMoreData() {
    if (data.length >= 8) return;
    List<String> newItems = ['Spell 5', 'Spell 6', 'Spell 7', 'Spell 8'];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        data.addAll(newItems);
        isEndOfList = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height - 135;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('Scroll View Rescue'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: data.length + 1,
        itemBuilder: (context, index) {
          Color color;
          if (index % 2 == 0) {
            color = Colors.blue;
          } else {
            color = Colors.green;
          }
          if (index == data.length) {
            if (isEndOfList) {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: Text(
                    'End of List',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            } else {
              loadMoreData();
              return const CircularProgressIndicator();
            }
          } else {
            return Column(
              children: [
                Container(
                  height: containerHeight * 0.25,
                  color: color,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                      'Spell ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
