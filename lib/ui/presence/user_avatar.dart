import 'package:flutter/material.dart';
import '../card/avatar.dart';
import '../theme.dart';
import 'dart:math';



class BuildAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avatarImage = 'https://picsum.photos/250?image=9';
    // final avatarImage = null;

    final avatarCrop = AppAvatarCrop.circle;

    if (avatarImage != null) {
      return SizedBox(
        width: 40,
        height: 40,
        child: _croppedImage(context, avatarImage, avatarCrop),
      );
    } else {
      return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppThemePalette.themeColorAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("data"),
                  BotSemicircle(
                    radius: 40,
                    color: AppThemePalette.themeColorSecondary,
                  ),
                ],
              )
          )
      );
    }
  }

  Widget _croppedImage(BuildContext context, String url, AppAvatarCrop? crop) {
    if (crop == AppAvatarCrop.square) {
      return ClipRect(
        child: Align(
          alignment: Alignment.center,
          widthFactor: 40,
          heightFactor: 40,
          child: Image.network(url),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(url),
      );
    }
  }
}

class BotSemicircle extends StatelessWidget {
  final double radius;
  final Color color;

  const BotSemicircle({
    required this.radius,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemicirclePainter(color: color),
      size: Size(radius, radius / 2),
    );
  }
}

class SemicirclePainter extends CustomPainter {
  final Color color;

  SemicirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, 0),
        width: size.width,
        height: size.height * 2,
      ),
      0,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}