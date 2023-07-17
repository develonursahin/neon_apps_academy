import 'package:flutter/material.dart';

class PageControlScreen extends StatefulWidget {
  PageControlScreen({Key? key}) : super(key: key);

  @override
  _PageControlScreenState createState() => _PageControlScreenState();
}

class _PageControlScreenState extends State<PageControlScreen> {
  final List<PageItem> pages = [
    PageItem(
      title: 'Important Announcement',
      subtitle: 'New regulations for the kingdom',
      image: NetworkImage(
          'https://lifehopeandtruth.com/cache/images/the-kingdom-of-god-the-rule-of-law_850_500_80.jpg'),
    ),
    PageItem(
      title: 'Upcoming Event',
      subtitle: 'Royal Ball in the palace',
      image:
          NetworkImage('https://i.ytimg.com/vi/gMRQhvGhYlA/maxresdefault.jpg'),
    ),
    PageItem(
      title: 'Historical Facts',
      subtitle: 'Discover the kingdom\'s rich history',
      image: NetworkImage(
          'https://www.timeforkids.com/wp-content/uploads/2020/09/TFK_200904_005.jpg'),
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Control'),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return PageItemWidget(page: page);
                },
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < pages.length; i++)
                  PageIndicator(isActive: i == currentPage),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem {
  final String title;
  final String subtitle;
  final ImageProvider image;

  PageItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class PageItemWidget extends StatelessWidget {
  final PageItem page;

  const PageItemWidget({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            page.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            page.subtitle,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Image(
            image: page.image,
            height: 200,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}
