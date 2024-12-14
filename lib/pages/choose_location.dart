import 'package:flutter/material.dart';
import 'package:world_clock/utility/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

List<WorldTime> updateFmt = [
  WorldTime(location: 'Belgium', flag: 'belgium.JPG', url: 'Belgium'),
  WorldTime(location: 'France', flag: 'france.JPG', url: 'France'),
  WorldTime(location: 'Germany', flag: 'germany.JPG', url: 'Germany'),
  WorldTime(location: 'Berlin', flag: 'germany.JPG', url: 'Berlin'),
  WorldTime(location: 'Italy', flag: 'italy.JPG', url: 'Italy'),
  WorldTime(location: 'Nigeria', flag: 'nigeria.JPG', url: 'Nigeria'),
  WorldTime(location: 'Poland', flag: 'poland.JPG', url: 'Poland'),
  WorldTime(location: 'Russia', flag: 'russia.JPG', url: 'Russia'),
  WorldTime(location: 'Bulgaria', flag: 'russia.JPG', url: 'Bulgaria'),
  WorldTime(location: 'USA', flag: 'usa.JPG', url: 'USA'),
  WorldTime(location: 'London', flag: 'uk.JPG', url: 'London'),
];


class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    void updateTime(index) async {
  WorldTime instance = updateFmt[index];
  await instance.getTime();
  Navigator.pop(context, {
      'location':instance.location,
      'time': instance.time,
      'flag':instance.flag,
      'isDay':instance.isDay,
  });
}
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Choose a Location',
            style: TextStyle(color: Colors.white, fontSize: 28.0),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: ListView.builder(
          itemCount: updateFmt.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(updateFmt[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${updateFmt[index].flag}'),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
