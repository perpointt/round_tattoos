import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _text = AppValues.unifiedTitle;
  double _radius = AppValues.unifiedRadius;
  double _font = AppValues.unifiedFontSize;
  double _letterSpacing = AppValues.unifiedLetterSpacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Round Tattoos demo',
        ),
        actions: [
          CupertinoButton(
            child: const Text(
              'Сбросить',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _text = AppValues.unifiedTitle;
              _radius = AppValues.unifiedRadius;
              _font = AppValues.unifiedFontSize;
              _letterSpacing = AppValues.unifiedLetterSpacing;
              setState(() {});
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: ArcText(
                        radius: _radius,
                        text: _text,
                        textStyle: TextStyle(
                          fontSize: _font,
                          color: Colors.black,
                          fontFamily: 'Fontaine',
                          letterSpacing: _letterSpacing,
                        ),
                        startAngleAlignment: StartAngleAlignment.start,
                        placement: Placement.outside,
                        direction: Direction.clockwise,
                      ),
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16)
                        .copyWith(bottom: 16),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Текст'),
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      initialValue: _text,
                      onChanged: (value) {
                        _text = value;
                        setState(() {});
                      },
                    ),
                  ),
                  _SliderWidget(
                    title: 'Радиус',
                    min: AppValues.minRadius,
                    max: AppValues.maxRadius,
                    value: _radius,
                    onChanged: (value) {
                      _radius = value;
                      setState(() {});
                    },
                  ),
                  _SliderWidget(
                    title: 'Шрифт',
                    min: AppValues.minFontSize,
                    max: AppValues.maxFontSize,
                    value: _font,
                    onChanged: (value) {
                      _font = value;
                      setState(() {});
                    },
                  ),
                  _SliderWidget(
                    title: 'Межбуквенное расстояние',
                    min: AppValues.minLetterSpacing,
                    max: AppValues.maxLetterSpacing,
                    value: _letterSpacing,
                    onChanged: (value) {
                      _letterSpacing = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliderWidget extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final void Function(double) onChanged;
  final String title;
  const _SliderWidget({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('$title: ${value.round()}'),
        ),
        Slider(
          min: min,
          max: max,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

abstract class AppValues {
  static const double minRadius = 20;
  static const double maxRadius = 200;

  static const double minFontSize = 14;
  static const double maxFontSize = 80;

  static const double minLetterSpacing = -20;
  static const double maxLetterSpacing = 20;

  static const double unifiedRadius = 100;
  static const double unifiedFontSize = 40;
  static const double unifiedLetterSpacing = 0;
  static const String unifiedTitle =
      'FLUTTER DART FLUTTER DART FLUTTER DART FLUTTER DART';
}

// final decorationPaint = Paint()
//   ..style = PaintingStyle.stroke
//   ..strokeCap = StrokeCap.round
//   ..strokeWidth = 32
//   ..color = Colors.yellow;

// void painterDelegate(Canvas canvas, Size size, ArcTextPainter painter) {
//   // final rect = Rect.fromCircle(
//   //   center: Offset(size.width / 2, size.height / 2),
//   //   radius: painter.radius,
//   // );
//   // canvas.drawImageNine(image, center, dst, paint)
//   // canvas.drawArc(
//   //   rect,
//   //   painter.startAngle,
//   //   painter.sweepAngle,
//   //   false,
//   //   decorationPaint,
//   // );

//   final center = Offset(size.width / 2, size.height / 2);
//   final radius = math.min(size.width, size.height) / 8;

//   // The circle should be paint before or it will be hidden by the path
//   Paint paintCircle = Paint()..color = Colors.black;
//   Paint paintBorder = Paint()
//     ..color = Colors.white
//     ..strokeWidth = size.width / 36
//     ..style = PaintingStyle.stroke;
//   // canvas.drawCircle(center, radius, paintCircle);
//   // canvas.drawCircle(center, radius, paintBorder);

//   double drawImageWidth = 0;
//   double drawImageHeight = -size.height * 0.8;

//   painter.paint(canvas, size);

//   Path path = Path()
//     ..addOval(Rect.fromLTWH(drawImageWidth, drawImageHeight, painter.radius * 2,
//         painter.radius * 2));

//   canvas.clipPath(path);

//   canvas.drawImage(
//       image!, new Offset(drawImageWidth - 200, drawImageHeight), new Paint());

//   painter.paint(canvas, size);
// }

// Future<ui.Image> loadImage(String imageName) async {
//   final data = await rootBundle.load('assets/$imageName');
//   return decodeImageFromList(data.buffer.asUint8List());
// }

// ui.Image? image;
