import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zigy/constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  final double size;
  const LoadingWidget({
    Key key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SpinKitCubeGrid(
          size: size ?? 20,
          color: color ?? primaryColor,
        ),
      ),
    );
  }
}
