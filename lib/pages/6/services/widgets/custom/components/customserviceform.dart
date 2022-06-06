import 'package:flutter/material.dart';
import '../index.dart';
import 'package:naver_crs/index.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomServiceForm extends StatelessWidget {
  const CustomServiceForm({
    Key? key,
    required this.service,
  }) : super(key: key);
  final String service;
  @override
  Widget build(BuildContext context) {
    var props = {}.obs;
    List filteredByDestination = [];
    for (Map item in findCatalog("services").toList()) {
      List itemList = item.values.toList();
      CatalogDto srv = CatalogDto(itemList);
      if (srv.description.toString().toUpperCase() ==
          service.toString().toUpperCase()) {
        filteredByDestination.add(srv);
      }
    }

    var row = filteredByDestination[0];

    props.value = row.value;

    return Obx(() {
      return Column(
        children: [
          FirstTextwidget(props: props),
        ],
      );
    });
  }
}

class FirstTextwidget extends StatelessWidget {
  final props;
  const FirstTextwidget({
    Key? key,
    required this.props,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var activities = props["activities"];
    var descriptions = props["descriptions"];
    var options = props["options"];

    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.01,
          top: MediaQuery.of(context).size.height * 0.01),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.4,
        // color: Colors.red[50],
        child: SingleChildScrollView(
          child: Column(
            children: [
              DescriptionWidget(description: descriptions[0]),
              OptionsWidget(options: options),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              DescriptionWidget(description: descriptions[1]),
              ActivitiesVideoGalleryWidget(activities: activities)
            ],
          ),
        ),
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
    required this.description,
  }) : super(key: key);

  final description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.justify,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: MediaQuery.of(context).size.width * 0.01,
        fontWeight: FontWeight.normal,
      )),
    );
  }
}

class ActivitiesVideoGalleryWidget extends StatelessWidget {
  const ActivitiesVideoGalleryWidget({
    Key? key,
    required this.activities,
  }) : super(key: key);

  final activities;

  @override
  Widget build(BuildContext context) {
    var actList = <Widget>[];
    for (var activity in activities) {
      actList.add(ActivityItem(item: {
        "title": activity["title"],
        "video": activity["video"],
        "image": activity["image"],
        "galleryimage": activity["galleryimage"],
      }));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: actList,
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    Key? key,
    required this.options,
  }) : super(key: key);

  final options;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            ItemWidget(icon: options[0]["icon"], text: options[0]["text"]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ItemWidget(icon: options[1]["icon"], text: options[1]["text"]),
          ],
        ),
        Spacer(),
        Column(
          children: [
            ItemWidget(icon: options[2]["icon"], text: options[2]["text"]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ItemWidget(icon: options[3]["icon"], text: options[3]["text"]),
          ],
        ),
        Spacer(),
        Column(
          children: [
            ItemWidget(icon: options[4]["icon"], text: options[4]["text"]),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ItemWidget(icon: options[5]["icon"], text: options[5]["text"]),
          ],
        ),
        Spacer(),
      ],
    );
  }
}

class ActivityItem extends StatelessWidget {
  final item;
  const ActivityItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return VideoItem(item: item);
            });
      },
      child: Image.asset(item["image"],
          width: MediaQuery.of(context).size.width * 0.25),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String icon;
  final String text;
  const ItemWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(icon),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        Text(
          text,
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: MediaQuery.of(context).size.width * 0.01,
            fontWeight: FontWeight.normal,
          )),
        ),
      ],
    );
  }
}
