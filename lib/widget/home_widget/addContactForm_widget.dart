import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stdev/service/contact_service.dart';
import 'package:stdev/utils/size_utils.dart';
import 'package:stdev/widget/button_widget.dart';
import 'package:stdev/widget/textField_widget.dart';

class AddContactFormWidget extends StatefulWidget {
  const AddContactFormWidget({super.key});

  @override
  State<AddContactFormWidget> createState() => _AddContactFormWidgetState();
}

class _AddContactFormWidgetState extends State<AddContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late String firstName, lastName, phone, email, notes;
  List? picture = [];
  bool buttonLoading = false;

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }

    setState(() {
      buttonLoading = true;
    });
    bool response = await ContactService.post(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      notes: notes,
      picture: picture ?? [],
    );
    setState(() {
      buttonLoading = false;
    });
    if (response) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context, response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: ScreenSize.width(context),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Add Contact",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomFormField(
                hintText: "First Name",
                onChange: (value) {
                  firstName = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'First Name cannot be empty!!';
                  }
                  return null;
                },
              ),
              CustomFormField(
                hintText: "Last Name",
                onChange: (value) {
                  lastName = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Last Name cannot be empty!!';
                  }
                  return null;
                },
              ),
              CustomFormField(
                hintText: "Email",
                onChange: (value) {
                  email = value!;
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),
              CustomFormField(
                hintText: "Phone Number",
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChange: (value) {
                  phone = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Phone Number cannot be empty!!';
                  }
                  return null;
                },
              ),
              CustomFormField(
                hintText: "Note",
                onChange: (value) {
                  notes = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Note cannot be empty!!';
                  }
                  return null;
                },
              ),
              CustomFormField(
                hintText: "Picture",
                onChange: (value) {
                  picture!.add(value);
                },
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ButtonWidget(
                    title: 'Submit',
                    loading: buttonLoading,
                    onPressed: () => _submit(),
                  )

                  // ElevatedButton(
                  //  onPressed: () => buttonLoading ? null : _submit(),
                  //  child: buttonLoading
                  //      ? const SizedBox(
                  //          width: 20,
                  //          height: 20,
                  //          child: CircularProgressIndicator(
                  //            valueColor:
                  //                AlwaysStoppedAnimation<Color>(Colors.white),
                  //          ),
                  //        )
                  //      : const Text('Submit'),
                  //),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
