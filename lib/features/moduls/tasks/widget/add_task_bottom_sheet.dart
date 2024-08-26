import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:todo_simple_app/core/firebase_utils.dart';
import 'package:todo_simple_app/core/services/snack_bar_service.dart';
import 'package:todo_simple_app/model/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    var lang = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              cursorColor: const Color(0xff5D9CEC),
              controller: titlecontroller,
              validator: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "PLZ Enter Your Title";
                }
                return null;
              },
              decoration: InputDecoration(
                // label: const Text("Password"),
                hintText: lang.enterTaskTitle,
                enabledBorder: const UnderlineInputBorder(),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5D9CEC), width: 2)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 2,
              cursorColor: const Color(0xff5D9CEC),
              controller: descriptioncontroller,
              validator: (value) {
                if (value == null || value
                    .trim()
                    .isEmpty) {
                  return "PLZ Enter Your Description";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: lang.enterYourDescription,
                enabledBorder: const UnderlineInputBorder(),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff5D9CEC), width: 2)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              lang.selectDate,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                getSelectedDate();
              },
              child: Text(
                DateFormat("dd MMM yyyy").format(selectedDate),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                  var taskModel = TaskModel(
                      title: titlecontroller.text,
                      description: descriptioncontroller.text,
                      selectedDate: selectedDate);
                  // print(taskModel.toFirestore());
                  EasyLoading.show();
                  FireBaseUtils.addTaskToFireStore(taskModel).then((value) {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      EasyLoading.dismiss();
                      SnackBarService.showSuccessMessage(
                          "Task Successfuly added");
                    }
                  });
                },
                child: Text(lang.save))
          ],
        ),
      ),
    );
  }

  getSelectedDate() async {
    var currentDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (currentDate != null) {
      setState(() {
        selectedDate = currentDate;
      });
    }
  }
}
