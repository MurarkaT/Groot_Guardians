import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';

import 'ProgressChart.dart';

class ChartPainter extends CustomPainter{
  final List<String> x;
  final List<double> y;
  final List<Score> scores;
  final double min,max;
  final BuildContext context;
  ChartPainter(this.x,this.y,this.min,this.max,this.context,this.scores);

  final linePaint=Paint()
    ..color=Colors.white
    ..style=PaintingStyle.stroke
    ..strokeWidth=1.0;

  final dotPaintFill=Paint()
    ..color=Colors.black
    ..style=PaintingStyle.fill
    ..strokeWidth=1.0;

  final yLabelStyle=TextStyle(color: Colors.white,fontSize: 12);
  final xLabelStyle = TextStyle(color:Colors.white,fontSize: 16,fontWeight: FontWeight.bold);
  static double border=10.0;
  static double radius=5.0;
  late DateTime dt;
  Map<Offset,int> mp={};


  @override
  void paint(Canvas canvas, Size size) {

    var canvasTch=TouchyCanvas(context, canvas);
    final clipRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.clipRect(clipRect);

    final drawableHeight = size.height - 2.0 * border;
    final drawableWidth = size.width - 2.0 * border;
    final hd = drawableHeight / 5.0;
    final wd = drawableWidth / this.x.length.toDouble();


    final height = hd * 3.0;
    final width = drawableWidth;
    //escape if values are invalid

    if (height <= 0.0 || width <= 0.0) return;
    if (max - min < 1.0e-6) return;

    final hr = height / (max - min); //height per unit value

    final left = border;
    final top = border;
    var c = Offset(left + wd / 2.0, top + height / 2.0);
    //_drawOutline(canvas, c, wd, height);

    final points = _computePoints(c, wd, height, hr);
    final path = _computePath(points);
    final labels = _computeLabels();


    canvas.drawPath(path, linePaint);
    _drawDataPoints(canvasTch,points,dotPaintFill);
    _drawLabels(canvas, labels,points, wd,top);

    //draw x labels
    final c1=Offset(c.dx,top+4.5*hd);
    _drawXLabels(canvas,c1,wd);
  }

  void _drawXLabels(Canvas canvas,Offset c,double wd){
    x.forEach((xp){

      drawTextCentered(canvas, c, xp, xLabelStyle, wd);
      c+= Offset(wd,0);
    });
  }


  void _drawDataPoints(TouchyCanvas canvas, List<Offset> points, Paint dotPaintFill) {
    int i=0;
    points.forEach((dp) {
      canvas.drawCircle(dp, radius, dotPaintFill,onTapDown: (tapdetail){
        dt=scores[mp[dp]!].time;
        print(dt);
      });
      canvas.drawCircle(dp, radius, linePaint);
    });
  }

  void _drawLabels(Canvas canvas, List<String> labels,List<Offset> points, double wd,double top) {
    var i=0;
    labels.forEach((label) {
      final dp=points[i];
      final dy=(dp.dy - 15.0)<top?15.0:-15.0;
      final ly=dp+Offset(0,dy);
      drawTextCentered(canvas, ly, label, yLabelStyle, wd);
      i++;
    });
  }



  Path _computePath(List<Offset> points) {

    final path=Path();
    for(var i=0;i<points.length;i++){
      final p=points[i];
      if(i==0){
        path.moveTo(p.dx, p.dy);
      }
      else{
        path.lineTo(p.dx, p.dy);
      }
    }

    return path;
  }

  List
  <Offset> _computePoints(Offset c,double width, double height,double hr){
    List<Offset> points=[];
    int idx=0;
    y.forEach((yp) {
      final yy=height-(yp-min)*hr;
      final dp=Offset(c.dx, c.dy-height/2.0+yy);
      points.add(dp);
      mp[dp]=idx;
      idx++;
      c+=Offset(width,0);
    });

    return points;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  final Paint outlinePaint=Paint()
    ..strokeWidth=1.0
    ..style=PaintingStyle.stroke
    ..color=Colors.white;


  void _drawOutline(Canvas canvas, Offset c,double width,double height){
    y.forEach((p) {
      final rect=Rect.fromCenter(center: c, width: width, height: height);
      canvas.drawRect(rect,outlinePaint);
      c+=Offset(width,0);
    });
  }
  List<String> _computeLabels(){
    return  y.map((yp)=> "${yp.toStringAsFixed(2)}").toList();
  }



  TextPainter measureText(
      String s,TextStyle style, double maxWidth,TextAlign align
      ){
    final span=TextSpan(text: s,style: style);
    final tp=TextPainter(text: span,textAlign: align,textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0,maxWidth: maxWidth);
    return tp;
  }

  Size drawTextCentered(Canvas canvas, Offset c, String text, TextStyle style, double maxWidth) {
    final tp=measureText(text,style,maxWidth,TextAlign.center);
    final offset=c+Offset(-tp.width/2.0, -tp.height/2.0);
    tp.paint(canvas, offset,);
    return tp.size;
  }}