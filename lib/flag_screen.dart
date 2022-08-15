import 'dart:ui';

import 'package:flag/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class MainFlag extends StatefulWidget {
  const MainFlag({Key? key}) : super(key: key);

  @override
  State<MainFlag> createState() => _MainFlagState();
}

class _MainFlagState extends State<MainFlag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlagWithAnimation(controller: _controller),
            const SizedBox(height: 20),
            const GradientText(),
            const SizedBox(height: 20),
            Text("75th 2022",
                style: GoogleFonts.rancho(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: ((bounds) {
        return LinearGradient(colors: [
          AppColor.saffron,
          AppColor.white.withOpacity(0.8),
          AppColor.green,
        ]).createShader(
            Rect.fromLTRB(0, 0, bounds.width, bounds.height));
      }),
      child: Text("Happy Independence Day",
          style: GoogleFonts.rancho(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(
                    color: AppColor.black,
                    blurRadius: 30,
                    offset: Offset(0, 0))
              ],
              color: Colors.black)),
    );
  }
}

class FlagWithAnimation extends StatelessWidget {
  const FlagWithAnimation({
    Key? key,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          highlightColor: AppColor.white,
          baseColor: AppColor.saffron,
          child: Container(
            height: 80,
            color: AppColor.saffron,
          ),
        ),
        Container(
          width: double.infinity,
          height: 80,
          color: AppColor.white,
          padding: const EdgeInsets.all(5),
          child: AnimatedBuilder(
              animation: _controller,
              child: SvgPicture.asset("assets/ashok_chakra.svg"),
              builder: (context, child) {
                return Transform.rotate(
                    angle: _controller.value * 6.3, child: child);
              }),
        ),
        Shimmer.fromColors(
          highlightColor: AppColor.white,
          baseColor: AppColor.green,
          child: Container(
            height: 80,
            color: AppColor.green,
          ),
        ),
      ],
    );
  }
}
