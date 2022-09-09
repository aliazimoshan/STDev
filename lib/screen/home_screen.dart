import 'package:stdev/service/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:stdev/model/contact_model.dart';
import 'package:stdev/widget/home_widget/addContactForm_widget.dart';
import 'package:stdev/widget/home_widget/contactCard_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ContactModel> contactList = [];
  bool loading = true;
  String error = "";

  getData() async {
    setState(() {
      loading = true;
      error = "";
    });
    try {
      contactList = await ContactService.get();
      setState(() {
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = true;
        error = e.toString();
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddContactFormWidget(),
        ).then((value) {
          if (value == true) {
            getData();
          }
        }),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(
          'My Contacts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromRGBO(250, 251, 250, 100),
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    return ContactCardWidget(
                      contactList[index],
                    );
                  },
                ),
        ),
      ),
    );
  }
}
