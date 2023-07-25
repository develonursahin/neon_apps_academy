import 'package:flutter/material.dart';

class GridViewScreen extends StatelessWidget {
  GridViewScreen({Key? key});

  final List<App> apps = [
    App(
      appName: 'PDF Maker',
      appIcon:
          'https://static.wixstatic.com/media/894657_4aad7a4ca6de4e9dbcdc7d8affc9ca90~mv2.png/v1/fill/w_76,h_76,al_c,q_95,enc_auto/Pdf%20Maker.png',
      releaseDate: '2023-01-01',
      appCategory: 'Category 1',
      storeURL:
          'https://www.neonapps.co/_files/ugd/894657_fbbc08c989eb4eebb3928801a2f268a3.pdf',
    ),
    App(
      appName: 'AI Art Creator',
      appIcon:
          'https://static.wixstatic.com/media/894657_a334c76c5f514046844132117d732f1e~mv2.png/v1/fill/w_76,h_76,al_c,q_95,enc_auto/Al%20Art%20Crator%20App.png',
      releaseDate: '2023-01-01',
      appCategory: 'Category 1',
      storeURL:
          'https://www.neonapps.co/_files/ugd/894657_45f01e3a87574b02b74902a09c66bed3.pdf',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid View'),
      ),
      body: GridView.builder(
        itemCount: apps.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AppDetailScreen(app: apps[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.network(
                        apps[index].appIcon,
                        width: 100,
                        height: 100,
                      ),
                      Text(apps[index].appName),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class App {
  final String appName;
  final String appIcon;
  final String releaseDate;
  final String appCategory;
  final String storeURL;

  App({
    required this.appName,
    required this.appIcon,
    required this.releaseDate,
    required this.appCategory,
    required this.storeURL,
  });
}

class AppDetailScreen extends StatelessWidget {
  final App app;

  AppDetailScreen({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app.appName),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              app.appIcon,
              width: 200,
              height: 200,
            ),
            Text('Release Date: ${app.releaseDate}'),
            Text('Category: ${app.appCategory}'),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Open the app store URL
              },
              child: Text('Open in App Store'),
            ),
          ],
        ),
      ),
    );
  }
}
