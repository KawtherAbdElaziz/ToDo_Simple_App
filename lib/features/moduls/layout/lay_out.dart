import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_simple_app/core/settings_provider.dart';
import '../settings/settings.dart';
import '../tasks/tasks.dart';
import '../tasks/widget/add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LayOut extends StatefulWidget {
  const LayOut({super.key});

  static String routName = "layout";

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {
  List<Widget> screensList = [const Tasks(), const Settings()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    var provider = Provider.of<SettingsProvider>(context);
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      extendBody: true,
      backgroundColor:
      provider.isDark() ? const Color(0xff060E1E) : const Color(0xffC8C9CB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTaskBottomSheet(),
          );
        },
        backgroundColor: provider.isDark()
            ? const Color(0xff141922)
            : const Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        elevation: 2,
        child: const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xff5D9CEC),
          child: Icon(
            Icons.add,
            size: 37,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.isDark()
            ? const Color(0xff141922)
            : const Color(0xffffffff),
        shape: const CircularNotchedRectangle(),
        height: 93,
        padding: EdgeInsets.zero,
        notchMargin: 12,
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/icons/icon_list.png"),
                  ),
                  label: lang.tasks),
              BottomNavigationBarItem(
                  icon: const ImageIcon(
                    AssetImage("assets/icons/icon_settings.png"),
                  ),
                  label: lang.settings)
            ]),
      ),
      body: screensList[currentIndex],
    );
  }
}
