import 'dart:developer';

import 'package:attestation/att_outlined_button.dart';
import 'package:attestation/att_text_field_widget.dart';
import 'package:attestation/checkbox_selecrion_vidget.dart';
import 'package:attestation/country_selection_dropdown_bunnton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ru', ''), // Spanish, no country code
      ],
      home: const MyHomePage(title: 'Attestation Web App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController patronymicController;
  SexSelector? _selector = SexSelector.male;
  String _dropdownValue = _list.first;
  DateTime _selectedDate = DateTime.now();

  static const List<String> _list = <String>[
    "Великобритания",
    "Франция",
    "Италия",
    "Испания",
    "Германия",
    "Чехия",
  ];

  final Map<String, bool> _checkSelectionItem = {
    "Английский": false,
    "Французкий": false,
    "Итальянский": false,
    "Испанский": false,
    "Немецкий": false,
    "Чешский": false,
  };

  static const List<String> _keys = <String>[
    "Английский",
    "Французкий",
    "Итальянский",
    "Испанский",
    "Немецкий",
    "Чешский",
  ];

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    patronymicController = TextEditingController();
    super.initState();
  }

  void _selectRadio(SexSelector? value) {
    log("$value");
    _selector = value;
    setState(() {});
  }

  void _dropDownSelector(String? value) {
    log("$value");
    _dropdownValue = value!;
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale("ru"),
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        initialEntryMode: DatePickerEntryMode.input,
        helpText: "D picker");
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    log("${_selectedDate.toLocal()}".split(' ').first);
    setState(() {});
  }

  void _selectCheckBox(bool? value, int index) {
    print(_keys[index]);
    print(_checkSelectionItem[_keys[index]]);
    print(value);
    _checkSelectionItem[_keys[index]] = value!;
    print(_checkSelectionItem[_keys[index]]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Анкета туриста",
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AttTextFieldWidget(
                    label: "Имя",
                    textEditingController: firstNameController,
                  ),
                  const SizedBox(height: 10),
                  AttTextFieldWidget(
                    label: "Фамилия",
                    textEditingController: lastNameController,
                  ),
                  const SizedBox(height: 10),
                  AttTextFieldWidget(
                    label: "Отчество",
                    textEditingController: patronymicController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Пол",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Radio<SexSelector>(
                      value: SexSelector.male,
                      groupValue: _selector,
                      onChanged: _selectRadio,
                    ),
                    const Text(
                      "Мужской",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 20),
                    Radio<SexSelector>(
                      value: SexSelector.female,
                      groupValue: _selector,
                      onChanged: _selectRadio,
                    ),
                    const Text(
                      "Женский",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 600,
              child: Row(
                children: [
                  Expanded(
                    child: CountrySelectionDropdownButton(
                      list: _list,
                      onTap: _dropDownSelector,
                      dropdownValue: _dropdownValue,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        _keys.length,
                        (index) => Row(
                              children: [
                                Checkbox(
                                  value: _checkSelectionItem[_keys[index]],
                                  onChanged: (value) {
                                    _selectCheckBox(value, index);
                                  },
                                ),
                                Text(
                                  _keys[index],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Text(
                  "Время прибытия",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 20),
                AttOutlinedButton(
                  onPressed: _selectDate,
                  child: Row(
                    children: [
                      Text(
                        DateFormat.yMMMMd("ru").format(_selectedDate),
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AttOutlinedButton(
              onPressed: () {},
              child: const Text(
                "Отправить",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum SexSelector { male, female }
