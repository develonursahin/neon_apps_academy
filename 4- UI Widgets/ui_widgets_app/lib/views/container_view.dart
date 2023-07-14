import 'package:flutter/material.dart';

class CustomContainerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Containers'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Mavi container, kalın border, border rengi sarı
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  border: Border.all(
                    color: Colors.yellow,
                    width: 4.0,
                  ),
                ),
              ),

              // 2. Yeşil container, border radius 20, içerisinde beyaz metin
              Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    'Container 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),

              // 3. Turuncu container, gradient arka plan
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                  ),
                ),
              ),

              // 4. Mor container, border kalınlığı 2
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),

              // 5. Siyah container, kenar yuvarlama, içerisinde beyaz metin
              Container(
                width: 180,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Container 5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),

              // 6. Sarı container, içerisinde beyaz ikon
              Container(
                width: 80,
                height: 80,
                color: Colors.yellow,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),

              // 7. Kırmızı container, gradient border
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    width: 4.0,
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(75),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.pink, Colors.purple],
                  ),
                ),
              ),

              // 8. Beyaz container, içerisinde mavi ikon
              Container(
                width: 100,
                height: 100,
                color: Colors.white,
                child: Icon(
                  Icons.check,
                  color: Colors.blue,
                  size: 60.0,
                ),
              ),

              // 9. Yeşil container, içerisinde resim
              Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                    image: AssetImage('assets/images/flower.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 10. Pembe container, border radius 50, içerisinde beyaz metin
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(60.0),
                ),
                child: Center(
                  child: Text(
                    'Container 10',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
