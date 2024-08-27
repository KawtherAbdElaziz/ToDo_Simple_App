import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_simple_app/core/firebase_utils.dart';
import 'package:todo_simple_app/core/settings_provider.dart';
import 'package:todo_simple_app/model/task_model.dart';

class TaskItemWidget extends StatefulWidget {
  final TaskModel taskModel;

  const TaskItemWidget({super.key, required this.taskModel});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var lang = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color:
              provider.isDark() ? const Color(0xff141922) : theme.primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Slidable(
        startActionPane: ActionPane(motion: const BehindMotion(), children: [
          SlidableAction(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.only(
              topLeft: Localizations.localeOf(context).languageCode == 'ar'
                  ? Radius.zero
                  : const Radius.circular(12),
              bottomLeft: Localizations.localeOf(context).languageCode == 'ar'
                  ? Radius.zero
                  : const Radius.circular(12),
              topRight: Localizations.localeOf(context).languageCode == 'ar'
                  ? const Radius.circular(12)
                  : Radius.zero,
              bottomRight: Localizations.localeOf(context).languageCode == 'ar'
                  ? const Radius.circular(12)
                  : Radius.zero,
            ),
            onPressed: (context) {
              EasyLoading.show();
              FireBaseUtils.deleteTask(widget.taskModel)
                  .then((value) => EasyLoading.dismiss());
            },
            backgroundColor: const Color(0xfffe4a49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: lang.delete,
          ),
          SlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (context) {
              showDialog(
                context: context,
                builder: (context) {
                  final titleController =
                      TextEditingController(text: widget.taskModel.title);
                  final descriptionController =
                      TextEditingController(text: widget.taskModel.description);

                  return AlertDialog(
                    title: Text(lang.editTask),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(labelText: lang.title),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration:
                              InputDecoration(labelText: lang.description),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(lang.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          // ignore: avoid_print
                          print("Save button pressed");

                          final updatedTask = widget.taskModel.copyWith(
                            title: titleController.text,
                            description: descriptionController.text,
                          );

                          EasyLoading.show();

                          // Use the editTask function here
                          FireBaseUtils.editTask(updatedTask).then((_) {
                            if (context.mounted) {
                              // ignore: avoid_print
                              print("Task updated successfully");
                              EasyLoading.dismiss();
                              Navigator.of(context).pop();
                            }
                          }).catchError((error) {
                            // ignore: avoid_print
                            print("Failed to update task: $error");
                            EasyLoading.dismiss();
                            // Handle error (e.g., show an error message)
                          });
                        },
                        child: Text(lang.save),
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: const Color(0xff4a90e2),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: lang.edit,
          ),
        ]),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          // padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          decoration: BoxDecoration(
              color: provider.isDark()
                  ? const Color(0xff141922)
                  : theme.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: ListTile(
              leading: Container(
                width: 6,
                height: 80,
                decoration: BoxDecoration(
                    color: const Color(0xff5D9CEC),
                    borderRadius: BorderRadius.circular(15)),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.taskModel.title,
                      style: theme.textTheme.bodyLarge),
                  Text(widget.taskModel.description,
                      style: theme.textTheme.bodyMedium),
                  Row(
                    children: [
                      const Icon(
                        Icons.alarm,
                        size: 15,
                        color: Color(0xff000000),
                      ),
                      Text(
                          DateFormat("dd MMM, yyyy")
                              .format(widget.taskModel.selectedDate),
                          style: theme.textTheme.bodySmall),
                    ],
                  )
                ],
              ),
              trailing: widget.taskModel.isDone
                  ? Text(
                      lang.done,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 14, color: const Color(0xff61e757)),
                    )
                  : InkWell(
                      onTap: () {
                        EasyLoading.show();
                        FireBaseUtils.updateTask(widget.taskModel)
                            .then((onValue) => EasyLoading.dismiss());
                      },
                      child: Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                            color: const Color(0xff5D9CEC),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.check,
                          size: 30,
                          color: Color(0xffffffff),
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}
