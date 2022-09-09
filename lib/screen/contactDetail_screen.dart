import 'package:fluttertoast/fluttertoast.dart';
import 'package:stdev/screen/home_screen.dart';
import 'package:stdev/service/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:stdev/model/contact_model.dart';
import 'package:stdev/utils/color_utils.dart';
import 'package:stdev/utils/size_utils.dart';
import 'package:stdev/widget/button_widget.dart';
import 'package:stdev/widget/detailContact_widget/contactDetailHeader_widget.dart';
import 'package:stdev/widget/detailContact_widget/contactDetailItem_widget.dart';
import 'package:stdev/widget/detailContact_widget/dialog_widget.dart';
import 'package:stdev/widget/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailScreen extends StatefulWidget {
  final String contactId;
  final String contactName;
  const ContactDetailScreen({
    super.key,
    required this.contactId,
    required this.contactName,
  });

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late ContactModel contactModel;
  bool loading = true;
  bool stackLoading = false;
  String error = "";

  getData() async {
    setState(() {
      loading = true;
      error = "";
    });
    try {
      contactModel = await ContactService.getDetail(widget.contactId);
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = e.toString();
      });
    }
  }

  deleteContact() async {
    showDialog(
      context: context,
      builder: (context) => DeleteDialogWidget(),
    ).then((value) async {
      if (value == true) {
        setState(() {
          stackLoading = true;
        });
        try {
          bool response = await ContactService.delete(id: contactModel.id);
          if (response) {
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          }
        } catch (e) {
          setState(() {
            stackLoading = false;
          });
          print(e.toString());
        }
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 20,
              ),
              SizedBox(width: 3),
              Text(
                "Back",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(244, 244, 244, 100),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: loading
                ? const CircularProgressIndicator()
                : error == ""
                    ? Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                contactHeaderWidget(contactModel),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                                  child: Text(
                                    "Other Detail",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black54),
                                  ),
                                ),
                                contactDetailItem(
                                  Icons.call_rounded,
                                  "Phone Number",
                                  contactModel.phone,
                                  onTab: () async {
                                    Uri url =
                                        Uri.parse("tel:${contactModel.phone}");
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                                contactDetailItem(
                                  Icons.mail,
                                  "Email Address",
                                  contactModel.email,
                                  onTab: () async {
                                    Uri url = Uri.parse(
                                        "mailto:${contactModel.phone}");
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                                contactDetailItem(
                                  Icons.note,
                                  "Notes",
                                  contactModel.notes,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20, top: 10),
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonWidget(
                                  title: "Edit",
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                        msg: "Coming Soon!!");
                                    //showDialog(
                                    //  context: context,
                                    //  builder: (context) =>
                                    //      UpdateContactFormWidget(
                                    //    contactModel: contactModel,
                                    //  ),
                                    //).then((value) {
                                    //  if (value == true) {
                                    //    getData();
                                    //  }
                                    //});
                                  },
                                  width: ScreenSize.width(context) / 3,
                                ),
                                ButtonWidget(
                                  title: "Delete",
                                  color: Colors.red,
                                  onPressed: () => deleteContact(),
                                  width: ScreenSize.width(context) / 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Text(
                        error,
                        textAlign: TextAlign.center,
                      ),
          ),
          stackLoading ? const FullScreenLoadingWidget() : Container(),
        ],
      ),
    );
  }
}
