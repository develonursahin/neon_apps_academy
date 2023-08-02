import 'package:flutter/material.dart';

class Article {
  final String title;
  final String thumbnail;
  final String description;

  Article(
      {required this.title,
      required this.thumbnail,
      required this.description});
}

class ListViewScreen extends StatelessWidget {
  ListViewScreen({super.key});

  final List<Article> articles = [
    Article(
      title: "Breaking News",
      thumbnail:
          "https://play-lh.googleusercontent.com/OABfRfKxyvf6PUg_6YBJXvbKSbegFsBKvFDEm5jOA0rC5k1la-OwmnWz6GK55vr3EGA",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
    ),
    Article(
      title: "Sports News",
      thumbnail:
          "https://play-lh.googleusercontent.com/JP5PdXtfZXB4PmlBjpsEbU4ZoDGhFCpcY3Q1y4q1bBTt9u35PwMuIyM1QEzTgZ_j4R0",
      description:
          "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.",
    ),
    Article(
      title: "Entertainment Buzz",
      thumbnail:
          "https://pbs.twimg.com/profile_images/876407288826822656/Yw64QATk_400x400.jpg",
      description:
          "Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.",
    ),
    Article(
      title: "Tech Updates",
      thumbnail:
          "https://www.ivcc.com/wp-content/uploads/2019/01/ivcc-tech-update-winter-e1567543098271-600x288.gif",
      description: "Nullam eleifend lectus non urna fringilla finibus.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(articles[index].thumbnail),
            title: Text(articles[index].title),
            subtitle: Text(articles[index].description),
            onTap: () {
// Handle article tap
            },
          );
        },
      ),
    );
  }
}
