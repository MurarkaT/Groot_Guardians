import 'package:flutter/material.dart';
import 'DeviceMap.dart';
import 'package:kanha1011/DeviceTable.dart';

class HomeManagement extends StatefulWidget {
  const HomeManagement({Key? key}) : super(key: key);

  @override
  State<HomeManagement> createState() => _HomeManagementState();
}

class _HomeManagementState extends State<HomeManagement>{

  final List<Widget> _pages=[
    const DeviceMap(),
    const DeviceTable(),
  ];
  int _index=0;


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
          BottomNavigationBarItem(icon: Icon(Icons.access_time),label: 'Time'),
          BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Add'),
        ],
      ),
    );
  }
}
