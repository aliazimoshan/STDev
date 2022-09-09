import 'package:flutter/material.dart';
import 'package:stdev/utils/size_utils.dart';
import 'package:stdev/widget/button_widget.dart';

class DeleteDialogWidget extends StatelessWidget {
  DeleteDialogWidget({super.key});

  bool buttonLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      title: const Text("Delete Contact"),
      content: const Text("Are you sure?"),
      actions: [
        Row(
          children: [
            SizedBox(width: 10),
            ButtonWidget(
              title: "No",
              width: ScreenSize.width(context) / 5,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 10),
            ButtonWidget(
              title: "Yes",
              color: Colors.red,
              width: ScreenSize.width(context) / 5,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}
