import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:naver_crs/index.dart';

class CruiseDetailWidget extends StatelessWidget {
  const CruiseDetailWidget({
    Key? key,
    this.row,
  }) : super(key: key);
  final row;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "${row['cruise_name']}",
            style: KTextSytle(
              context: context,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 204, 164, 61),
            ).getStyle(),
          ),
          Image.network(
            "${row['image']}",
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
          Text(
            getCruiseItinerary(row),
            style: KTextSytle(
              context: context,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ).getStyle(),
          ),
          Obx(() {
            try {
              return SfCalendar(
                firstDayOfWeek: 1,
                backgroundColor: Colors.white,
                minDate: arrivalDate.value.add(Duration(days: 1)),
                maxDate: departureDate.value.add(Duration(days: -1)),
                view: CalendarView.month,
                dataSource: MeetingDataSource(getDataSource(
                    "${row['cruise_itinerary']}"
                        .replaceAll("[", " ")
                        .replaceAll("]", " "))),
                monthViewSettings: MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              );
            } catch (e) {
              log(e);
              return Text(
                "No Calendar Aivalable",
                style: KTextSytle(
                  context: context,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 204, 164, 61),
                ).getStyle(),
              );
            }
          })
        ],
      ),
    );
  }
}
