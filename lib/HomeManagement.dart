import 'package:flutter/material.dart';
import 'package:kanha1011/allApps.dart';
import 'DeviceMap.dart';
import 'package:kanha1011/DeviceTable.dart';
import 'package:kanha1011/main.dart';


class HomeManagement extends StatefulWidget {
  const HomeManagement({Key? key}) : super(key: key);

  @override
  State<HomeManagement> createState() => _HomeManagementState();
}

class _HomeManagementState extends State<HomeManagement>{

  final List<Widget> _pages=[
    const AllApps(),
    const DeviceMap(),
    const DeviceTable(),
  ];
  int _index=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (selectedIndex){
          setState(() {
            _index=selectedIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'All Apps'),
          BottomNavigationBarItem(icon: Icon(Icons.maps_home_work_outlined),label: 'Location'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ],
      ),
    );
  }
}
