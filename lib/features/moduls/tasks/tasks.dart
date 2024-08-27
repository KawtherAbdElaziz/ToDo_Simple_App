// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_simple_app/core/firebase_utils.dart';
import 'package:todo_simple_app/model/task_model.dart';

import 'widget/task_item_widget.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  static String routName = "Tasks";

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final EasyInfiniteDateTimelineController _controller =
  EasyInfiniteDateTimelineController();
  var _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                height: mediaQuery.size.height * 0.18,
                width: mediaQuery.size.width,
                color: const Color(0xff5D9CEC),
                child: Text(lang.todo, style: theme.textTheme.titleLarge),
              ),
              Positioned(
                top: 100,
                child: SizedBox(
                  width: mediaQuery.size.width,
                  child: EasyInfiniteDateTimeLine(
                    locale: lang.localeName == 'ar' ? 'ar' : 'en',
                    showTimelineHeader: false,
                    controller: _controller,
                    firstDate: DateTime(2024),
                    focusDate: _focusDate,
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    timeLineProps:
                    const EasyTimeLineProps(separatorPadding: 15),
                    dayProps: EasyDayProps(
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        monthStrStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xff5D9CEC),
                            fontWeight: FontWeight.bold),
                        dayStrStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xff5D9CEC),
                            fontWeight: FontWeight.bold),
                        dayNumStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xff5D9CEC),
                            fontWeight: FontWeight.bold),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12)),
                        monthStrStyle: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        dayStrStyle: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        dayNumStyle: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      todayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12)),
                        monthStrStyle: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        dayStrStyle: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        dayNumStyle: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    onDateChange: (selectedDate) {
                      setState(() {
                        _focusDate = selectedDate;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<TaskModel>>(
            stream: FireBaseUtils.getOnTimeReadFromFireStore(_focusDate),
            builder: (context, snapShot) {
              if (snapShot.hasError) {
                return Text(lang.somethingWentWrong);
              }
              if (snapShot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }
              var tasksList = snapShot.data;
              return ListView.builder(
                itemBuilder: (context, index) =>
                    TaskItemWidget(taskModel: tasksList![index]),
                itemCount: tasksList?.length ?? 0,
              );
            },
          ),
        )

        // Expanded(
        //   child: FutureBuilder<List<TaskModel>>(
        //     future: FireBaseUtils.getOnTimeReadFromFireStore(_focusDate),
        //     builder: (context, snapShot) {
        //       if (snapShot.hasError) {
        //         return const Text("Something went wrong");
        //       }
        //       if (snapShot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(
        //             color: Colors.blue,
        //           ),
        //         );
        //       }
        //       var tasksList = snapShot.data;
        //       return ListView.builder(
        //         itemBuilder: (context, index) =>
        //             TaskItemWidget(taskModel: tasksList![index]),
        //         itemCount: tasksList?.length ?? 0,
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
