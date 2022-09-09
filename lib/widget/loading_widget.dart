import 'package:flutter/material.dart';
import 'package:stdev/utils/size_utils.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  const FullScreenLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.width(context),
      alignment: Alignment.center,
      height: ScreenSize.height(context),
      color: Colors.black.withOpacity(0.3),
      child: const CircularProgressIndicator(),
    );
  }
}
