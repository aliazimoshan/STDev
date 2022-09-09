//import 'package:flutter/material.dart';
//import 'package:stdev/model/contact_model.dart';
//import 'package:stdev/service/contact_service.dart';
//import 'package:stdev/utils/size_utils.dart';
//import 'package:stdev/widget/button_widget.dart';
//import 'package:stdev/widget/textField_widget.dart';

//class UpdateContactFormWidget extends StatefulWidget {
//  final ContactModel contactModel;
//  const UpdateContactFormWidget({super.key, required this.contactModel});

//  @override
//  State<UpdateContactFormWidget> createState() =>
//      _UpdateContactFormWidgetState();
//}

//class _UpdateContactFormWidgetState extends State<UpdateContactFormWidget> {
//  final _formKey = GlobalKey<FormState>();
//  late TextEditingController firstName,
//      lastName,
//      phone,
//      email,
//      notes = TextEditingController();
//  List? picture = [];
//  bool buttonLoading = false;

//  @override
//  void initState() {
//    super.initState();
//  }

//  setDefaultValue() {
//    setState(() {
//      firstName.text = widget.contactModel.firstName;
//      lastName.text = widget.contactModel.lastName;
//      phone.text = widget.contactModel.phone;
//      email.text = widget.contactModel.email;
//      notes.text = widget.contactModel.notes;
//      picture = widget.contactModel.picture;
//    });
//  }

//  void _submit() async {
//    final isValid = _formKey.currentState?.validate();
//    if (!isValid!) {
//      return;
//    }

//    setState(() {
//      buttonLoading = true;
//    });
//    bool response = await ContactService.post(
//      firstName: firstName.text,
//      lastName: lastName.text,
//      email: email.text,
//      phone: phone.text,
//      notes: notes.text,
//      picture: picture ?? [],
//    );
//    setState(() {
//      buttonLoading = false;
//    });
//    if (response) {
//      Navigator.pop(context, response);
//    }
//  }

//  @override
//  Widget build(BuildContext context) {
//    return AlertDialog(
//      shape: const RoundedRectangleBorder(
//        borderRadius: BorderRadius.all(
//          Radius.circular(32.0),
//        ),
//      ),
//      content: Form(
//        key: _formKey,
//        child: SizedBox(
//          width: ScreenSize.width(context),
//          child: ListView(
//            shrinkWrap: true,
//            children: [
//              const Padding(
//                padding: EdgeInsets.all(10),
//                child: Text(
//                  "Add Contact",
//                  style: TextStyle(
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold,
//                  ),
//                ),
//              ),
//              CustomFormField(
//                hintText: "First Name",
//                controller: firstName,
//                validator: (value) {
//                  if (value!.isEmpty) {
//                    return 'First Name cannot be empty!!';
//                  }
//                  return null;
//                },
//              ),
//              CustomFormField(
//                hintText: "Last Name",
//                controller: lastName,
//                validator: (value) {
//                  if (value!.isEmpty) {
//                    return 'Last Name cannot be empty!!';
//                  }
//                  return null;
//                },
//              ),
//              CustomFormField(
//                hintText: "Email",
//                controller: email,
//                validator: (value) {
//                  if (value!.isEmpty ||
//                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                          .hasMatch(value)) {
//                    return 'Enter a valid email!';
//                  }
//                  return null;
//                },
//              ),
//              CustomFormField(
//                hintText: "Phone Number",
//                controller: phone,
//                validator: (value) {
//                  if (value!.isEmpty) {
//                    return 'Phone Number cannot be empty!!';
//                  }
//                  return null;
//                },
//              ),
//              CustomFormField(
//                hintText: "Note",
//                controller: notes,
//                validator: (value) {
//                  if (value!.isEmpty) {
//                    return 'Note cannot be empty!!';
//                  }
//                  return null;
//                },
//              ),
//              CustomFormField(
//                hintText: "Picture",
//                onChange: (value) {
//                  picture!.add(value);
//                },
//              ),
//              Padding(
//                  padding: const EdgeInsets.all(10.0),
//                  child: ButtonWidget(
//                    title: 'Submit',
//                    loading: buttonLoading,
//                    onPressed: () => _submit(),
//                  )

//                  // ElevatedButton(
//                  //  onPressed: () => buttonLoading ? null : _submit(),
//                  //  child: buttonLoading
//                  //      ? const SizedBox(
//                  //          width: 20,
//                  //          height: 20,
//                  //          child: CircularProgressIndicator(
//                  //            valueColor:
//                  //                AlwaysStoppedAnimation<Color>(Colors.white),
//                  //          ),
//                  //        )
//                  //      : const Text('Submit'),
//                  //),
//                  )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
