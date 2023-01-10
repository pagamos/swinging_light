import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin  {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.white.withOpacity(0.2),
            ),

            Positioned(
              top: 0,
              left: 0,
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  width: size.width * 0.5,
                  height: 400,
                  child: CustomPaint(
                    painter: MyLightPainter(
                      widthScreen: size.width,
                      heightScreen: size.height
                    ),
                  ),
                ),
              ),
            ),


            Positioned( // light
              top: 150 + 5,
              left: size.width / 2 - 15,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.white.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 15,
                      blurRadius: 20,
                      offset: Offset(0, 3),
                    ),
                  ]
                ),
              )
            ),

            CustomPaint( // line wire
              size: Size(300, 300),
              painter: MyLinePainter(
                posX: size.width / 2 - 2
              ),
            ),

            Positioned( // the black thing like a cone
              top: 150 - 12.5,
              left: size.width / 2 - 12.5,
              child: Container(
                width: 25,
                height: 25,
                child: CustomPaint(
                  size: Size(26, 26),
                  painter: MyLampBasePainter(
                    posX: size.width / 2
                  ),
                ),
              )
            ),
          ],
        )
      )
    );
  }
}

class MyLightPainter extends CustomPainter {

  final double widthScreen;
  final double heightScreen;

  const MyLightPainter({this.widthScreen = 0.0, this.heightScreen = 1});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

    double quarterScreen = size.width / 4;

    Path pathLines = Path()
    ..addRect(Rect.fromLTWH(0, 0, widthScreen, heightScreen))
    ..moveTo(size.width, 150)
    ..lineTo(quarterScreen, 150 + size.height)
    ..quadraticBezierTo(
      size.width, 150 + size.height + 100,
      widthScreen - quarterScreen, 150 + size.height
    );
    canvas.drawPath(pathLines, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyLampBasePainter extends CustomPainter {

  final double posX;

  const MyLampBasePainter({this.posX = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path pathLines = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width / 2 - 3, 0)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width / 2 + 3, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(pathLines, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyLinePainter extends CustomPainter {

  final double posX;

  const MyLinePainter({this.posX = 0.0});

  @override
  void paint(Canvas canvas, Size size) {

    final p1 = Offset(posX + 2, 0);
    final p2 = Offset(posX + 2, 150);
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}