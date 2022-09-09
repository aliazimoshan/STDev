import 'package:flutter/material.dart';
import 'package:stdev/utils/color_utils.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final onPressed;
  final double? width;
  final bool loading;
  const ButtonWidget({
    super.key,
    required this.title,
    this.color,
    this.onPressed,
    this.width,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(color ?? ColorUtils.blue),
      ),
      onPressed: loading && onPressed == null ? () {} : onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        child: loading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
