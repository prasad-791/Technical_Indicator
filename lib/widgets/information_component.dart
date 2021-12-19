import 'package:flutter/material.dart';
import 'package:technical_indicator/configurations/config.dart';

import 'information_table.dart';
import 'option_selector.dart';

class InformationComponent extends StatefulWidget {
  final String tag;
  final String title;
  final Map<String,String> infoRowList;
  final List<String> options;
  final dynamic tableData;
  const InformationComponent({Key? key, required this.tableData, required this.options, required this.title, required this.tag, required this.infoRowList,}) : super(key: key);

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

  List<Map<String,List<String>>> getTableData(){
    if(widget.options.isEmpty){
      return widget.tableData;
    }else{
      return widget.tableData[widget.options[selectedOption]];
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
          child: OptionSelector(defaultValue: widget.options[selectedOption], options: widget.options, selectedOption: (val){
            setState(() {
              selectedOption = widget.options.indexWhere((element) => element==val);
            });
          }),
        ):Container(),
        SizedBox(height: h*0.02,),
        // Container(padding: EdgeInsets.symmetric(horizontal: w*0.03),child: InformationTable(tableHeaders: widget.tableHeaders,tableBody: getTableBody(),)),
        Container(padding: EdgeInsets.symmetric(horizontal: w*0.03),child: InformationTable(tableData: getTableData(),)),
        SizedBox(height: h*0.01,),
      ],
    );
  }
}
