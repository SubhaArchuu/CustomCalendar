# calender_event

Calender Event

## Getting Started

This project help you to customize the month cell based on the appointment using SfCalendar.

  -custom month cell builder
  -custom agenda
  -dynamic max and min date updation


try this 2 method:
1. Custom cell method ->
 appointmentDisplayMode: MonthAppointmentDisplayMode.none,

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


and create custom monthCellBuilder widget.

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
                    Text(
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


2. without using month cell builder

just command this line
 // monthCellBuilder: monthCellBuilder,

and change the appointmentDisplayMode to MonthAppointmentDisplayMode.appointment

                monthViewSettings: MonthViewSettings
                (
                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
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

-> uncommand the below line for dynamically update from and to date from model

               // minDate: (_startDateTime.text.toString() != "") ? DateTime.parse(_startDateTime.text.toString()) : DateTime.now() ,
               // maxDate:(_endDateTime.text.toString() != "") ? DateTime.parse(_endDateTime.text.toString()) :DateTime(DateTime.now().year, DateTime.now().month+3, DateTime.now().day, 00, 45, 0),



-> Initial date as current DateTime
  initialDisplayDate: DateTime(DateTime.now().year,
                    DateTime.now().month, DateTime.now().day, 00, 45, 0),
               
