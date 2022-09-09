import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stdev/constant/token.dart';
import 'package:stdev/model/contact_model.dart';
import 'package:stdev/constant/urls.dart';
import 'package:stdev/utils/dio_helper.dart';

class ContactService {
  static Future<List<ContactModel>> get() async {
    try {
      List<ContactModel> dataModel = [];
      Response response = await DioHelper.get(CONTACTS_URL);

      if (response.statusCode == 200) {
        for (int i = 0; i < response.data.length; i++) {
          dataModel.add(ContactModel.fromMap(response.data[i]));
        }
        return dataModel;
      } else {
        throw response.data;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future post({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String notes,
    required List picture,
  }) async {
    try {
      //List<ContactModel> dataModel = [];

      Map body = {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "notes": notes,
        "phone": phone,
        "picture": picture.toList(),
      };

      //var body = jsonEncode(data);
      Response response = await DioHelper.post(CONTACTS_URL, body: body);

      if (response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Contact added successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        return true;
      } else {
        throw response.data;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error accrued while adding contact: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw e.toString();
    }
  }

  static Future<ContactModel> getDetail(String id) async {
    try {
      Response response = await DioHelper.get("$CONTACTS_URL/$id");

      if (response.statusCode == 200) {
        ContactModel contactModel = ContactModel.fromMap(response.data);
        return contactModel;
      } else {
        throw response.data;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future delete({
    required String id,
  }) async {
    try {
      //List<ContactModel> dataModel = [];

      Response response = await DioHelper.delete("$CONTACTS_URL/$id");
      //var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Contact deleted successfully",
        );
        return true;
      } else {
        throw response.data;
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error accrued while adding contact: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception(e);
    }
  }
}
