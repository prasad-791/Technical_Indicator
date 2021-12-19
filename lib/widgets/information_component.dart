import 'package:flutter/material.dart';
import 'package:technical_indicator/configurations/config.dart';
import 'package:technical_indicator/models/time_instance.dart';

import 'information_table.dart';
import 'option_selector.dart';

class InformationComponent extends StatefulWidget {
  final String tag;
  final String title;
  final Map<String,String> infoRowList;
  final List<String> tableHeaders;
  final List tableBody;
  final List<String> options;
  final List<TableData> tableBodyOptions;
  const InformationComponent({Key? key, required this.tableBodyOptions, required this.options, required this.title, required this.tag, required this.infoRowList, required this.tableHeaders, required this.tableBody}) : super(key: key);

  @override
  _InformationComponentState createState() => _InformationComponentState();
}

class _InformationComponentState extends State<InformationComponent> {

  int selectedOption = 0;

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

    if(widget.infoRowList.isEmpty){
      return [Container()];
    }

    List<Column> rowList = [];
    rowList.add(Column(
      children: [
        Text(widget.infoRowList["buy"]??"-",style:const TextStyle(fontSize: 18,color: Colors.white),),
        const Text("Buy",style: TextStyle(fontSize: 14,color: Color.fromARGB(100, 255, 255, 255)),),
      ],
    ));
    rowList.add(Column(
      children: [
        Text(widget.infoRowList["neutral"]??"-",style:const TextStyle(fontSize: 18,color: Colors.white),),
        const Text("Neutral",style: TextStyle(fontSize: 14,color: Color.fromARGB(100, 255, 255, 255)),),
      ],
    ));
    rowList.add(Column(
      children: [
        Text(widget.infoRowList["sell"]??"-",style:const TextStyle(fontSize: 18,color: Colors.white),),
        const Text("Sell",style: TextStyle(fontSize: 14,color: Color.fromARGB(100, 255, 255, 255)),),
      ],
    ));
    return rowList;
  }

  Widget buildInfoRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: getInfoRowList(),
    );
  }



  List getTableBody(){
    if(widget.options.isEmpty){
      return widget.tableBody;
    }else{
      return widget.tableBodyOptions[selectedOption].data;
    }
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
        widget.options.isNotEmpty?Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.25),
          child: OptionSelector(defaultValue: widget.options[0], options: widget.options, selectedOption: (val){
            setState(() {
              selectedOption = widget.tableBodyOptions.indexWhere((element) => element.title == val);
            });
          }),
        ):Container(),
        SizedBox(height: h*0.02,),
        Container(padding: EdgeInsets.symmetric(horizontal: w*0.03),child: InformationTable(tableHeaders: widget.tableHeaders,tableBody: getTableBody(),)),
        SizedBox(height: h*0.01,),
      ],
    );
  }
}
