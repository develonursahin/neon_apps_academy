import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool _isVisible = true;
  double _rotationAngle = 0.0;
  double _boxSize = 150.0;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _rotateView() {
    setState(() {
      _rotationAngle += 45.0;
    });
  }

  void _moveView() {
    if (_animationController!.isCompleted) {
      _animationController!.reverse();
    } else {
      _animationController!.forward();
    }
  }

  void _changeSize() {
    setState(() {
      if (_boxSize == 150.0) {
        _boxSize = 200.0;
      } else {
        _boxSize = 150.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ulfr\'s Magic'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Görünmezlik Büyüsü',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleVisibility,
              child: Text(_isVisible ? 'Gizle' : 'Göster'),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _rotationAngle * 3.1415926535 / 180,
                  child: child,
                );
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Döndürme Büyüsü',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _rotateView,
              child: const Text('Döndür'),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _animationController!,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animationController!.value * 50),
                  child: child,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _boxSize,
                height: 50,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Hareket Büyüsü',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _moveView,
              child: const Text('Hareket Et'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _changeSize,
              child: const Text('Boyut Büyüsü'),
            ),
          ],
        ),
      ),
    );
  }
}
