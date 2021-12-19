import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_indicator/configurations/config.dart';

class InformationTable extends StatefulWidget {

  final List<Map<String,List<String>>> tableData;

  const InformationTable({Key? key,required this.tableData}) : super(key: key);

  @override
  State<InformationTable> createState() => _InformationTableState();
}

class _InformationTableState extends State<InformationTable> {

  final List<String> _headers = [];

  List<Widget> getHeaders(){
    List<Widget> headers = [];

    widget.tableData.forEach((element) {
      element.forEach((key, value) {
        headers.add(Text(key,style: const TextStyle(fontSize: 14,color: Color.fromRGBO(255, 255, 255, 0.6)),));
        _headers.add(key);
      });
    });
    return headers;
  }

  List<Widget> getColumns(var w,var h){

    Map<String,List<String>> column1 = widget.tableData[0];
    Map<String,List<String>> column2 = widget.tableData[1];
    Map<String,List<String>> column3 = widget.tableData[2];

    List<String> col1 = [];
    List<String> col2 = [];
    List<String> col3 = [];

    column1.forEach((key, value) {
      col1 = value;
    });
    column2.forEach((key, value) {
      col2 = value;
    });
    column3.forEach((key, value) {
      col3 = value;
    });

    List<Row> rows = [];

    for(int i=0;i<col1.length;i++){
      Column c1 = Column(
        children: [
          Container(margin:EdgeInsets.only(top: h*0.025),padding: EdgeInsets.only(left: 20),width:w*0.3,child: Text(col1[i],textAlign: TextAlign.start,style: TextStyle(color: Colors.white,fontSize: 16),softWrap: true,))
        ],
      );
      Column c2 = Column(
        children: [
          Container(margin:EdgeInsets.only(top: h*0.025),width:w*0.3,child: Text(col2[i],textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16),softWrap: true,))
        ],
      );
      Column c3 = Column(
        children: [
          Container(margin:EdgeInsets.only(top: h*0.025),padding: EdgeInsets.only(right: 10),width:w*0.3,child: Text(col3[i],textAlign: TextAlign.end,style: TextStyle(fontSize: 16,
              color: !indicatorLabels.contains(col3[i].toUpperCase()) ? const Color.fromARGB(100,255, 255, 255) : indicatorColors[indicatorLabels.indexOf(col3[i].toUpperCase())],
          ),softWrap: true,))
        ],
      );

      rows.add(Row(
        children: [
          c1,
          c2,
          c3
        ],
      ));
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {


    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;


    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: const Color(0xff121212),
              borderRadius: BorderRadius.circular(7),
            ),
            padding: EdgeInsets.symmetric(vertical: h*0.01,horizontal: w*0.07),
            width:w,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getHeaders(),
            )
        ),
        ...getColumns(w, h),
      ],
    );
  }
}
