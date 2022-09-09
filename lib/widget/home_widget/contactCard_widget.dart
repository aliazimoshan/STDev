// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:stdev/model/contact_model.dart';
import 'package:stdev/utils/color_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screen/contactDetail_screen.dart';

class ContactCardWidget extends StatefulWidget {
  final ContactModel contactModel;
  const ContactCardWidget(this.contactModel, {super.key});

  @override
  State<ContactCardWidget> createState() => _ContactCardWidgetState();
}

class _ContactCardWidgetState extends State<ContactCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactDetailScreen(
              contactId: widget.contactModel.id,
              contactName:
                  "${widget.contactModel.firstName} ${widget.contactModel.lastName}",
            ),
          ),
        ),
        title: Text(
          '${widget.contactModel.firstName} ${widget.contactModel.lastName}',
        ),
        subtitle: Text(
          widget.contactModel.phone,
        ),
        leading: Container(
          alignment: Alignment.center,
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorUtils.blue,
            image: widget.contactModel.picture.isNotEmpty
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.contactModel.picture[0],
                    ),
                  )
                : null,
          ),
        ),
        trailing: dropDownWidget(),
      ),
    );
  }

  Widget dropDownWidget() {
    return DropdownButton<String>(
      icon: const Icon(Icons.more_vert_outlined),
      underline: Container(),
      onChanged: (String? value) async {
        if (value == "Call") {
          Uri url = Uri.parse("tel:${widget.contactModel.phone}");
          if (!await launchUrl(url)) {
            throw 'Could not launch $url';
          }
        } else {
          Uri url = Uri.parse("mailto:${widget.contactModel.email}");
          if (!await launchUrl(url)) {
            throw 'Could not launch $url';
          }
        }
      },
      items: ["Call", "Email"].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
