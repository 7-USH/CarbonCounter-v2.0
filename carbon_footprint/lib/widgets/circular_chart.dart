// ignore_for_file: avoid_renaming_method_parameters, must_be_immutable, sized_box_for_whitespace

import 'package:carbon_footprint/constants/themes.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:velocity_x/src/flutter/shimmer.dart';

class ProgressPainter extends CustomPainter {
  //
  Color defaultCircleColor;
  Color percentageCompletedCircleColor;
  double completedPercentage;
  double circleWidth;

  ProgressPainter(
      {required this.defaultCircleColor,
      required this.percentageCompletedCircleColor,
      required this.completedPercentage,
      required this.circleWidth});

  getPaint(Color color) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint defaultCirclePaint = getPaint(defaultCircleColor);
    Paint progressCirclePaint = getPaint(percentageCompletedCircleColor);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, defaultCirclePaint);

    double arcAngle = 2 * pi * (completedPercentage / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, progressCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter painter) {
    return true;
  }
}

class MiddleRing extends StatelessWidget {
  final double width;

  const MiddleRing({Key? key, required this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          height: width * 0.3,
          width: width * 0.3,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            // ignore: prefer_const_literals_to_create_immutables
          ),
        ),
      ),
    );
  }
}

class CircularChart extends StatefulWidget {
  final double width;
  final double height;
  final double calculationNumber;
  CustomPainter painter;
  CircularChart(
      {Key? key,
      required this.calculationNumber,
      required this.width,
      required this.height,
      required this.painter})
      : super(key: key);

  @override
  _CircularChartState createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  @override
  Widget build(BuildContext context) {
    final int number = widget.calculationNumber.toInt();
    return Container(
      width: widget.height,
      height: widget.height,
      decoration:
          const BoxDecoration(
            color: Colors.transparent, shape: BoxShape.circle,

            ),
      child: Stack(alignment: AlignmentDirectional.center, children: [
        MiddleRing(
          width: widget.height * 1.5,
        ),
        Container(
          height: widget.height + 80,
          width: widget.width + 80,
          child: CustomPaint(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "CO₂",
                      style: Theme.of(context).textTheme.headline1,
                    ).shimmer(
                      primaryColor: kPrimeColor,
                      secondaryColor: kPrimeColor.withOpacity(0.8)
                    ),
                    Text(
                      "$number Kg",
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                )),
            painter: widget.painter,
          ),
        )
      ]),
    );
  }
}
