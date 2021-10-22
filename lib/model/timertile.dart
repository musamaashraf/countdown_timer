import 'package:hive/hive.dart';
part 'timertile.g.dart';

@HiveType(typeId: 0)
class TimerTile extends HiveObject {
  @HiveField(10)
  late String myIndex;

  @HiveField(0)
  late String title;

  @HiveField(1)
  late String subtitle;

  @HiveField(2)
  late String timerOnetitle;

  @HiveField(3)
  late DateTime timeOneTo;

  @HiveField(4)
  late String timerTwotitle;

  @HiveField(5)
  late DateTime timeTwoTo;

  @HiveField(6)
  late String timerThreetitle;

  @HiveField(7)
  late DateTime timeThreeTo;

  @HiveField(8)
  late String image;

  @HiveField(9)
  late String notes;

  @HiveField(11)
  late DateTime start;
}
