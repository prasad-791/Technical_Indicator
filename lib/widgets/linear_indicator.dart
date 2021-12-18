import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:technical_indicator/configurations/config.dart';

class LinearIndicator extends StatefulWidget {
  final int index;
  const LinearIndicator({Key? key,required this.index}) : super(key: key);

  @override
  _LinearIndicatorState createState() => _LinearIndicatorState();
}

class _LinearIndicatorState extends State<LinearIndicator> {


  List<LinearGaugeRange> getRanges(){
    return indicatorColors.map((e) => LinearGaugeRange(
      edgeStyle: LinearEdgeStyle.bothCurve,
      startValue: positions[indicatorColors.indexOf(e)]-10,
      endValue: positions[indicatorColors.indexOf(e)]+10,
      startWidth: 10,
      midWidth: 10,
      endWidth: 10,
      color: e,
    )).toList();
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SfLinearGauge(
      orientation: LinearGaugeOrientation.vertical,
      showTicks: false,
      showLabels: false,
      showAxisTrack: false,
      markerPointers: <LinearWidgetPointer>[
        LinearWidgetPointer(
          value: positions[widget.index].toDouble(),
          child: Container(
            width: w*0.4,
            height: h*0.05,
            padding: EdgeInsets.only(left: w*0.03),
            color: Colors.transparent,
            child: ChatBubble(
              shadowColor: Colors.black,
              backGroundColor: indicatorColors[widget.index],
              clipper: ChatBubbleClipper2(type: BubbleType.receiverBubble,nipRadius: 1,nipWidth: 10),
              child: Text(indicatorLabels[widget.index],style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),),
            ),
          ),
        ),
      ],
      ranges: getRanges(),
    );
  }
}
