import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_simple_app/core/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // final List<String> _langauges = ["English", "عربي"];
  // final List<String> _theme = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var lang = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    final List<String> langauges = ["English", "عربي"];
    final List<String> theme0 = [lang.light, lang.dark];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
          height: mediaQuery.size.height * 0.18,
          width: mediaQuery.size.width,
          color: const Color(0xff5D9CEC),
          child: Text(lang.settings, style: theme.textTheme.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: Text(lang.langauge,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: SizedBox(
            width: 320,
            height: 50,
            child: CustomDropdown<String>(
              hintText: 'Select Langauge',
              items: langauges,
              initialItem: provider.currentLangauge == "en"
                  ? langauges[0]
                  : langauges[1],
              onChanged: (value) {
                if (value == "English") {
                  provider.changeCurrentLangauge("en");
                }
                if (value == "عربي") {
                  provider.changeCurrentLangauge("ar");
                }
                log('changing value to: $value');
              },
              decoration: CustomDropdownDecoration(
                closedFillColor:
                    provider.isDark() ? const Color(0xff141A2E) : Colors.white,
                closedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color:
                      provider.isDark() ? theme.primaryColorDark : Colors.black,
                ),
                expandedFillColor:
                    provider.isDark() ? const Color(0xff141A2E) : Colors.white,
                expandedSuffixIcon: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color:
                      provider.isDark() ? theme.primaryColorDark : Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(lang.mode,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: SizedBox(
            width: 320,
            height: 50,
            child: CustomDropdown<String>(
              hintText: 'Select Theme',
              items: theme0,
              initialItem: provider.currentThemeMode == ThemeMode.light
                  ? theme0[0]
                  : theme0[1],
              onChanged: (value) {
                if (value == "Light" || value == "فاتح") {
                  provider.changeCurrentTheme(ThemeMode.light);
                }
                if (value == "Dark" || value == "داكن") {
                  provider.changeCurrentTheme(ThemeMode.dark);
                }
                log('changing value to: $value');
              },
              decoration: CustomDropdownDecoration(
                closedFillColor:
                    provider.isDark() ? const Color(0xff141A2E) : Colors.white,
                closedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color:
                      provider.isDark() ? theme.primaryColorDark : Colors.black,
                ),
                expandedFillColor:
                    provider.isDark() ? const Color(0xff141A2E) : Colors.white,
                expandedSuffixIcon: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color:
                      provider.isDark() ? theme.primaryColorDark : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
