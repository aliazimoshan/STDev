import 'package:flutter/material.dart';
import 'package:stdev/model/contact_model.dart';
import 'package:stdev/utils/color_utils.dart';

Widget contactHeaderWidget(ContactModel contactModel) {
  return Container(
    color: ColorUtils.lightGrey,
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: ColorUtils.blue,
                shape: BoxShape.circle,
                image: contactModel.picture.isNotEmpty
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          contactModel.picture[0],
                        ),
                      )
                    : null,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            "${contactModel.firstName} ${contactModel.lastName}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            contactModel.phone,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    ),
  );
}
