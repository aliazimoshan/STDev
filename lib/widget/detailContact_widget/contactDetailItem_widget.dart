import 'package:flutter/material.dart';
import 'package:stdev/utils/color_utils.dart';

Widget contactDetailItem(IconData icon, String title, String value, {onTab}) {
  return GestureDetector(
    onTap: onTab,
    child: Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Icon(icon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ColorUtils.textGrey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const Spacer(),
          onTab != null
              ? const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}
