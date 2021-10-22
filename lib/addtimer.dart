import 'package:countdown_timer/model/timertile.dart';
import 'package:countdown_timer/routes/routenames.dart';
import 'package:countdown_timer/style/colors.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddTimerPage extends StatefulWidget {
  const AddTimerPage({
    Key? key,
    this.newTile = true,
    this.timerTile,
  }) : super(key: key);
  final bool newTile;
  final TimerTile? timerTile;

  @override
  _AddTimerPageState createState() => _AddTimerPageState();
}

class _AddTimerPageState extends State<AddTimerPage> {
  TextEditingController mainTitle = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  TextEditingController timerOneTitle = TextEditingController();
  TextEditingController timerTwoTitle = TextEditingController();
  TextEditingController timerThreeTitle = TextEditingController();
  TextEditingController timerOne = TextEditingController();
  TextEditingController timerTwo = TextEditingController();
  TextEditingController timerThree = TextEditingController();
  // DateTime? timeOne;
  // DateTime? timerTwo;
  // DateTime? timerThree;
  final _formKey = GlobalKey<FormState>();

  void addTimer(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      TimerTile tile = TimerTile()
        ..image = ''
        ..notes = ''
        ..title = mainTitle.text
        ..subtitle = subTitle.text
        ..timeOneTo = DateTime.parse(timerOne.text.trim())
        ..timeThreeTo = DateTime.parse(timerThree.text.trim())
        ..timeTwoTo = DateTime.parse(timerTwo.text.trim())
        ..timerOnetitle = timerOneTitle.text
        ..timerThreetitle = timerThreeTitle.text
        ..timerTwotitle = timerTwoTitle.text;
      final box = Hive.box<TimerTile>('timerTile');
      await box.add(tile);
      Navigator.pop(context);
    }
  }

  void saveTimer(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      widget.timerTile!.title = mainTitle.text;
      widget.timerTile!.subtitle = subTitle.text;
      widget.timerTile!.timerOnetitle = timerOneTitle.text;
      widget.timerTile!.timerTwotitle = timerTwoTitle.text;
      widget.timerTile!.timerThreetitle = timerThreeTitle.text;
      widget.timerTile!.timeOneTo = DateTime.parse(timerOne.text);
      widget.timerTile!.timeTwoTo = DateTime.parse(timerTwo.text);
      widget.timerTile!.timeThreeTo = DateTime.parse(timerThree.text);
    }
  }

  @override
  void initState() {
    print('inside addtimer');
    if (!widget.newTile) {
      mainTitle.text = widget.timerTile!.title;
      subTitle.text = widget.timerTile!.subtitle;
      timerOneTitle.text = widget.timerTile!.timerOnetitle;
      timerTwoTitle.text = widget.timerTile!.timerTwotitle;
      timerThreeTitle.text = widget.timerTile!.timerThreetitle;
      timerOne.text = widget.timerTile!.timeOneTo.toString();
      timerTwo.text = widget.timerTile!.timeTwoTo.toString();
      timerThree.text = widget.timerTile!.timeThreeTo.toString();
      widget.timerTile!.save();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'Menu',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Palette.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(color: Palette.primary),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, homeRoute);
              },
              title: const Text('Home'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Terms & Conditions'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Add Timer',
          style: TextStyle(color: Palette.primary, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: Palette.primary,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: mainTitle,
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Title:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: subTitle,
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Subtitle:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a subtitle.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: timerOneTitle,
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Timer One Title:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter timer one title.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                DateTimePicker(
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Timer One Date To:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  type: DateTimePickerType.dateTime,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1,
                      DateTime.now().month, DateTime.now().day),
                  controller: timerOne,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter timer one time.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: timerTwoTitle,
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Timer Two Title:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter timer two title.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                DateTimePicker(
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Timer Two Date To:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  type: DateTimePickerType.dateTime,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1,
                      DateTime.now().month, DateTime.now().day),
                  controller: timerTwo,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter timer two time.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: timerThreeTitle,
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Timer Three Title:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter timer three title.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                DateTimePicker(
                  decoration: InputDecoration(
                    fillColor: Palette.white,
                    labelText: 'Timer Three Date To:',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Palette.grey),
                    ),
                  ),
                  type: DateTimePickerType.dateTime,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1,
                      DateTime.now().month, DateTime.now().day),
                  controller: timerThree,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter timer three time.';
                    }
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                GestureDetector(
                  onTap: () {
                    widget.newTile ? addTimer(context) : saveTimer(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 22.0, horizontal: 22.0),
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0.0, 8.0),
                          blurRadius: 16.0,
                          color: Palette.grey.withOpacity(0.6),
                        ),
                      ],
                    ),
                    child: Text(
                      widget.newTile ? 'Add Timer' : 'Save Timer',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Palette.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
