import 'package:flutter/material.dart';
import 'package:technical_indicator/configurations/config.dart';

import 'information_table.dart';
import 'option_selector.dart';

class InformationComponent extends StatefulWidget {
  final String tag;
  final String title;
  final Map<String,String> infoRowList;
  final List<String> tableHeaders;
  final List tableBody;
  const InformationComponent({Key? key, required this.title, required this.tag, required this.infoRowList, required this.tableHeaders, required this.tableBody}) : super(key: key);

  @override
  _InformationComponentState createState() => _InformationComponentState();
}

class _InformationComponentState extends State<InformationComponent> {

  Widget buildHeader(String val){
    return Align(
      alignment: Alignment.center,
      child: Text(val,style: const TextStyle(color: Colors.white,fontSize: 18),),
    );
  }

  Widget infoViewer(String val, Color bgColor, var h, var w){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w*0.04,vertical: h*0.015),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(val.toUpperCase(),style: const TextStyle(fontSize: 12,color: Colors.white),),
    );
  }

  List<Widget> getInfoRowList(){
    List<Column> rowList = [];
    widget.infoRowList.forEach((key, value) {
      rowList.add(Column(
        children: [
          Text(value,style:const TextStyle(fontSize: 18,color: Colors.white),),
          Text(key,style: const TextStyle(fontSize: 14,color: Color.fromARGB(100, 255, 255, 255)),),
        ],
      ));
    });
    return rowList;
  }

  Widget buildInfoRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: getInfoRowList(),
    );
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Column(
      children: [
        buildHeader(widget.title),
        SizedBox(height: h*0.03,),
        infoViewer(widget.tag.toUpperCase(), indicatorColors[indicatorLabels.indexOf(widget.tag.toUpperCase())], h, w),
        SizedBox(height: h*0.03,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.1),
          child: buildInfoRow(),
        ),
        SizedBox(height: h*0.02,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.25),
          child: OptionSelector(defaultValue: 'Exponential', options: const ['Exponential','Simple'], selectedOption: (ind){

          }),
        ),
        SizedBox(height: h*0.02,),
        Container(padding: EdgeInsets.symmetric(horizontal: w*0.03),child: InformationTable(tableHeaders: widget.tableHeaders,tableBody: widget.tableBody,)),
        SizedBox(height: h*0.01,),
      ],
    );
  }
}
