import 'package:flutter/material.dart';
import 'package:naya_project/utils/universal_utilities.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: Shimmer.fromColors(
        baseColor: UniversalVariables.blackColor,
        highlightColor: Colors.white,
        child: Image.asset("assets/logo.png"),
        period: Duration(seconds: 1),
      ),
    );
  }
}
