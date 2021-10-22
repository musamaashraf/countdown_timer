import 'package:countdown_timer/addtimer.dart';
import 'package:countdown_timer/constants/constants.dart';
import 'package:countdown_timer/model/edittile.dart';
import 'package:countdown_timer/model/timertile.dart';
import 'package:countdown_timer/routes/routenames.dart';
import 'package:countdown_timer/style/colors.dart';
import 'package:countdown_timer/style/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  CommonStyles commonStyles = CommonStyles();
  List<Widget> listwidget = List.empty(growable: true);
  int lastLength = 0;
  TimerTile lastTile = TimerTile();
  late AnimationController animationController;
  late BuildContext myContext;

  void addTimer(BuildContext context) async {
    TimerTile tile = TimerTile()
      ..image = ''
      ..myIndex = 'tile$lastLength'
      ..notes = ''
      ..subtitle = lastTile.subtitle
      ..timeOneTo = lastTile.timeOneTo
      ..timeThreeTo = lastTile.timeThreeTo
      ..timeTwoTo = lastTile.timeTwoTo
      ..timerOnetitle = lastTile.timerOnetitle
      ..timerThreetitle = lastTile.timerThreetitle
      ..timerTwotitle = lastTile.timerTwotitle
      ..title = lastTile.title + " ${lastLength - 1}"
      ..start = DateTime.now();

    final box = Hive.box<TimerTile>('timerTile');

    await box.add(tile);
    setState(() {});
  }

  @override
  void initState() {
    myContext = context;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
              onTap: () {},
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
        actions: [
          IconButton(
            onPressed: () {
              if (listwidget.isEmpty) {
                Navigator.pushNamed(context, addTimerRoute);
              } else {
                addTimer(context);
              }
            },
            icon: const Icon(
              Icons.add,
              color: Palette.primary,
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Palette.primary,
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
          child: ValueListenableBuilder<Box<TimerTile>>(
            valueListenable: Hive.box<TimerTile>('timerTile').listenable(),
            builder: (context, box, _) {
              final List<TimerTile> timerTiles = box.values.toList().cast();
              if (listwidget.isEmpty) {
                if (timerTiles.length > 0) {
                  // listwidget.clear();
                  // timerTiles.forEach((element) {
                  //   listwidget.add(buildTile(context, element));
                  // });
                  lastTile = timerTiles.last;
                  lastLength = timerTiles.length;
                }
              }
              if (lastLength < timerTiles.length) {
                // listwidget.add(buildTile(context, timerTiles.last));
                lastTile = timerTiles.last;
                lastLength = timerTiles.length;
              }
              if (timerTiles.isEmpty) {
                lastLength = 0;
              }
              return buildContent(timerTiles);
            },
          )),
    );
  }

  Widget buildContent(List<TimerTile> timerTiles) {
    if (timerTiles.isEmpty) {
      return const Center(
        child: Text(
          'No timers yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: timerTiles.length,
        itemBuilder: (BuildContext context, int index) {
          final transaction = timerTiles[index];

          return buildTile(context, transaction);
        },
      );
    }
  }

  Container buildTile(BuildContext context, TimerTile timerTile) {
    print('Key: ${timerTile.key}\n');
    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Palette.grey.withOpacity(0.4),
            offset: const Offset(0.0, 4.0),
            blurRadius: 12.0,
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.86,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                timerTile.title,
                style: const TextStyle(
                    color: Palette.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return MoreSettings.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      child: Text(choice),
                      onTap: () {
                        if (choice == MoreSettings.EditTile) {
                          print('pressed edit');
                          Navigator.pushNamed(myContext, addTimerRoute,
                              arguments: EditTile(false, timerTile: timerTile));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (mainContext) => AddTimerPage(
                          //               newTile: false,
                          //               timerTile: timerTile,
                          //             )));
                        }
                        if (choice == MoreSettings.DeleteTile) {
                          print('pressed delete');
                          timerTile.delete();
                        }
                      },
                    );
                  }).toList();
                },
              )
            ],
          ),
          Text(
            timerTile.subtitle,
            style: const TextStyle(
              color: Palette.black,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTimer(
                  context,
                  timerTile.timerOnetitle,
                  timerTile.timeOneTo.millisecondsSinceEpoch + 1000 * 30,
                  (timerTile.timeOneTo.millisecondsSinceEpoch / 1000).round()),
              buildTimer(
                  context,
                  timerTile.timerTwotitle,
                  timerTile.timeTwoTo.millisecondsSinceEpoch + 1000 * 30,
                  (timerTile.timeTwoTo.millisecondsSinceEpoch / 1000).round()),
              buildTimer(
                  context,
                  timerTile.timerThreetitle,
                  timerTile.timeThreeTo.millisecondsSinceEpoch + 1000 * 30,
                  (timerTile.timeThreeTo.millisecondsSinceEpoch / 1000)
                      .round()),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonStyles.tileButton(
                  context: context, onTap: () {}, text: 'Notes'),
              commonStyles.tileButton(
                  context: context, onTap: () {}, text: 'Images'),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }

  Column buildTimer(
      BuildContext context, String timerName, int endTime, int seconds) {
    // int endTime = DateTime(2021, 09, 22).millisecondsSinceEpoch + 1000 * 30;
    CountdownTimerController controller =
        CountdownTimerController(endTime: endTime);

    // animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(minutes: (seconds / 60).toInt()),
    //   animationBehavior: AnimationBehavior.preserve,
    // )..addListener(() {
    //     setState(() {});
    //   });
    // animationController.repeat(reverse: true);
    print('${seconds % 0.99} p0.99');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          timerName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Palette.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.2,
          width: MediaQuery.of(context).size.width * 0.2,
          child: CircularProgressIndicator(
            value: seconds % 0.99,
            color: Palette.primary,
            strokeWidth: 16.0,
            backgroundColor: Palette.grey,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        // CircularPercentIndicator(
        //   radius: 60.0,
        //   lineWidth: 5.0,
        //   percent: seconds % 0.99,
        //   progressColor: Palette.primary,
        // ),
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          // height: MediaQuery.of(context).size.width * 0.20,
          alignment: Alignment.center,
          child: CountdownTimer(
            endTime: endTime,
            controller: controller,
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return Text('00:00:00');
              }
              if (time.days == null && time.hours == null && time.min == null) {
                return Text('${time.sec}');
              } else if (time.days == null && time.hours == null) {
                return Text(' ${time.min}:${time.sec}');
              } else if (time.days == null) {
                return Text('${time.hours}:${time.min}:${time.sec}');
              } else {
                return Text('${time.days} day, ${time.hours} hours');
              }
            },
          ),
        ),
        // CircularCountDownTimer(
        //   width: MediaQuery.of(context).size.width * 0.20,
        //   height: MediaQuery.of(context).size.width * 0.20,
        //   controller: CountDownController(),
        //   isReverse: true,
        //   strokeWidth: 10.0,
        //   strokeCap: StrokeCap.round,
        //   duration: seconds,
        //   fillColor: Palette.white,
        //   ringColor: Palette.primary,
        //   textFormat: (seconds < 60) ? 'S' : 'HH:mm:ss',
        // ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      ],
    );
  }
}
