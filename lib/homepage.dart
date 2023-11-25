import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'DeviceMap.dart';
import 'allApps.dart';
import 'glass_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Image.asset("assets/images/on_boarding_images/stars.gif",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,

          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 55),
                Text("Hello Guardian,", style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.white,fontSize: 33)),),
                Text("Select an option below to tailor your child's", style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                Text("online safety.", style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                SizedBox(height: 40),
                GlassBox(height: 380, width: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 70,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Track your child\'s live location here',
                          style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.white,fontSize: 21)),),
                        //SizedBox(height: 5),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DeviceMap()));
                          },
                        ),
                      ],
                    )
                ),
                GlassBox(height: 380, width: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                          size: 70,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Monitor your Child\'s screen time here',
                          style: GoogleFonts.shadowsIntoLightTwo(textStyle: TextStyle(color: Colors.white,fontSize: 18)),),
                        //SizedBox(height: 5),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllApps()));
                          },
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}