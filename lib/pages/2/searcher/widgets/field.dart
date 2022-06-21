// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naver_crs/index.dart';

// ignore: must_be_immutable
class SearcherField extends StatelessWidget {
  SearcherField({Key? key, this.data, required this.formKey}) : super(key: key);

  final List? data;
  GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    TextEditingController? controller = TextEditingController();

    return Obx(() {
      return Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextFormField(
              // controller: controller,
              initialValue:
                  searchResult!.value == '' ? null : searchResult!.value,
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
              onChanged: (value) {
                filterFindTourData(context, value);
              },
              onFieldSubmitted: (value) {
                formKey.currentState!.save();
              },
              onSaved: (value) {
                filterFindTourData(context, value);
              }),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              resetFindTourData(context, controller);
            },
          ),
        ),
      );
    });
  }
}
