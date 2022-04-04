// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../index.dart';

class SearcherField extends StatelessWidget {
  const SearcherField({Key? key, this.data, required this.formKey})
      : super(key: key);

  final List? data;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    TextEditingController? controller = TextEditingController();

    return Obx(() {
      var srt = searchResult!.value;
      srt = searchResult!.value;
      return Card(
        child: ListTile(
          leading: Icon(Icons.search),
          title: TextFormField(
              // controller: controller,
              initialValue:
                  searchResult!.value == "" ? null : searchResult!.value,
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
              onChanged: (value) {
                filterData(context, value);
              },
              onFieldSubmitted: (value) {
                formKey.currentState!.save();
              },
              onSaved: (value) {
                filterData(context, value);
              }),
          trailing: IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              if (searchResult!.value.isNotEmpty) {
                controller.clear();
                searchResult!.value = '';
                filteredData.value = data!;
                var detail = getDetail(context, filteredData);
                searcherDetail.value = (detail);
              }
            },
          ),
        ),
      );
    });
  }
}
