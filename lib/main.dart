import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

void main() => runApp(const AgendaViewCustomization());

class AgendaViewCustomization extends StatelessWidget {
  const AgendaViewCustomization({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomAgenda(),
    );
  }
}

class CustomAgenda extends StatefulWidget {
  const CustomAgenda({super.key});

  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<CustomAgenda> {
  final List<Appointment> _appointmentDetails = <Appointment>[];
  late _DataSource dataSource;

  CalendarController _calendarController = CalendarController();



  @override
  void initState() {
    super.initState();
    dataSource = getCalendarDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,
        elevation: 5.0,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Text(
              'Custom Calendar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[


            Container(
              height : 350,
              child: SfCalendar(
                view: CalendarView.month,
                selectionDecoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.indigo, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle,
                ),
                showNavigationArrow: true,
                dataSource: dataSource,
                initialSelectedDate: DateTime.now().add(const Duration(days: -1)),
                onSelectionChanged: selectionChanged,
                todayHighlightColor: Color(0xFFcc0066),
                showDatePickerButton: true,
                showTodayButton: true,
                allowedViews: <CalendarView>
                [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month,
                  CalendarView.schedule
                ],
                viewNavigationMode: ViewNavigationMode.snap,
                monthCellBuilder: monthCellBuilder,
                monthViewSettings: MonthViewSettings
                (
                  appointmentDisplayMode: MonthAppointmentDisplayMode.none,
              appointmentDisplayCount : 2,
                numberOfWeeksInView: 3,
                  monthCellStyle: MonthCellStyle(
                      backgroundColor: Color(0xFFFFFFF),
                      textStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Arial'),
                      todayTextStyle: TextStyle(
                          fontSize: 12,
                          backgroundColor: Color(0xFFcc0066),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial'),
                      trailingDatesTextStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          fontFamily: 'Arial'),
                      leadingDatesTextStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                          fontFamily: 'Arial')),
                ),


              ),
            ),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 0),
                    color: Colors.black12,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(2),
                      itemCount: _appointmentDetails.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.all(2),
                            height: 60,
                            color: _appointmentDetails[index].color,
                            child: ListTile(
                              leading: Column(
                                children: <Widget>[
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? ''
                                      //  "EEE, MMM d, ''yy"
                                        : DateFormat("MMM d").format(
                                        _appointmentDetails[index].startTime),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        height: 1.5),
                                  ),
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? 'All day'
                                        : '',
                                    style: const TextStyle(
                                        height: 0.5, color: Colors.white),
                                  ),
                                  Text(
                                    _appointmentDetails[index].isAllDay
                                        ? ''
                                        : DateFormat('EEE').format(
                                        _appointmentDetails[index].endTime),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                  child: Icon(
                                    getIcon(_appointmentDetails[index].subject),
                                    size: 25,
                                    color: Colors.white,
                                  )),
                              title: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${_appointmentDetails[index].subject}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white)),
                                      Text(
                                          ' rooms available',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ],
                                  )),
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                        height: 5,
                      ),
                    )))
          ],
        ),
      ),
    ));
  }

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.appointments.isNotEmpty) {
      Appointment? appointment= details.appointments[0] as Appointment?;
        return

          Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: appointment!.color/*Color(Random().nextInt(0xffffffff)).withAlpha(0xff)*/,
                border: Border.all(color: Colors.grey, width: 0.5)),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    const Divider(color: Colors.transparent,),
                    (DateTime.now().day.toString() == details.date.day.toString()) ? Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6), color: Color(0xFFcc0066)),
                    child: Text(
                      details.date.day.toString(),
                      textAlign: TextAlign.center,
                      style:  TextStyle(color: Colors.white),
                    ),
                  ) : Text(
                    details.date.day.toString(),
                    textAlign: TextAlign.center,
                    ),
                    const Divider(color: Colors.transparent,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.house_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 4,),
                        Text(
                          appointment!.subject.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
      }
   // }
    return Container(
      height: 140,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: Center(
          child: Text(
            details.date.day.toString(),
            textAlign: TextAlign.center,
          )
      ),
    );


  }

  void selectionChanged(CalendarSelectionDetails calendarSelectionDetails) {
    getSelectedDateAppointments(calendarSelectionDetails.date);
  }

  void getSelectedDateAppointments(DateTime? selectedDate) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _appointmentDetails.clear();
      });

      if (dataSource.appointments!.isEmpty) {
        return;
      }

      for (int i = 0; i < dataSource.appointments!.length; i++) {
        Appointment appointment = dataSource.appointments![i] as Appointment;
        /// It return the occurrence appointment for the given pattern appointment at the selected date.
        final Appointment? occurrenceAppointment = dataSource.getOccurrenceAppointment(appointment, selectedDate!, '');
        if ((DateTime(appointment.startTime.year, appointment.startTime.month,
            appointment.startTime.day) == DateTime(selectedDate.year,selectedDate.month,
            selectedDate.day)) || occurrenceAppointment != null) {
          setState(() {
            _appointmentDetails.add(appointment);
          });
        }
      }
    });
  }

  _DataSource getCalendarDataSource() {
    final List<Appointment> appointments = <Appointment>[];

    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 2, hours: 4)),
      endTime: DateTime.now().add(const Duration(days: 2, hours: 5)),
      subject: '12',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 3, hours: 1)),
      endTime: DateTime.now().add(const Duration(days: 3, hours: 2)),
      subject: '6',
      color: Colors.amber,
    ));



    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 2, days: 4)),
      endTime: DateTime.now().add(const Duration(hours: 3, days: 4)),
      subject: '28',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 1, days: 5)),
      endTime: DateTime.now().add(const Duration(hours: 1, days: 5)),
      subject: '7',
      color: Colors.red,
    ));

    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 7, hours: 2)),
      endTime: DateTime.now().add(const Duration(days: 7, hours: 3)),
      subject: "40",
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 6, hours: 1)),
      endTime: DateTime.now().add(const Duration(days: 6, hours: 2)),
      subject: '19',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(hours: 3, days: 8)),
      endTime: DateTime.now().add(const Duration(hours: 4, days: 8)),
      subject: '2',
      color: Colors.amber,
    ));
    appointments.add(Appointment(
        startTime: DateTime.now().add(const Duration(hours: 2, days: 10)),
        endTime: DateTime.now().add(const Duration(hours: 2, days: 10)),
        subject: '20',
        color: Colors.green,
        recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=10'
    ));
    appointments.add(Appointment(
        startTime: DateTime.now().add(const Duration(hours: 1, days: 11)),
        endTime: DateTime.now().add(const Duration(hours: 2, days: 11)),
        subject: '8',
        color: Colors.amber,
        isAllDay: true));


    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      subject: '32',
      color: Colors.green,
    ));




    return _DataSource(appointments);
  }

  IconData getIcon(String subject) {
    if (subject == 'Planning') {
      return Icons.subject;
    } else if (subject == 'Development Meeting   New York, U.S.A') {
      return Icons.people;
    } else if (subject == 'Support - Web Meeting   Dubai, UAE') {
      return Icons.settings;
    } else if (subject == 'Project Plan Meeting   Kuala Lumpur, Malaysia') {
      return Icons.check_circle_outline;
    } else if (subject == 'Retrospective') {
      return Icons.people_outline;
    } else if (subject == 'Project Release Meeting   Istanbul, Turkey') {
      return Icons.people_outline;
    } else if (subject == 'Customer Meeting   Tokyo, Japan') {
      return Icons.settings_phone;
    } else if (subject == 'Release Meeting') {
      return Icons.view_day;
    } else {
      return Icons.info_outline;
    }
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}