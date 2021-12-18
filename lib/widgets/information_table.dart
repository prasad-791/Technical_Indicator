import 'package:flutter/material.dart';
import 'package:technical_indicator/configurations/config.dart';

class InformationTable extends StatelessWidget {
  final List<String> tableHeaders;
  final List tableBody;
  const InformationTable({Key? key, required this.tableHeaders,required this.tableBody}) : super(key: key);

  List<TableRow> getTableBody(var h,var w){
    return tableBody.map((e) => TableRow(
        children: [
          Container(
              padding:EdgeInsets.symmetric(vertical: h*0.01,horizontal: w*0.05),
              width:w,
              child: Row(
                children: [
                  Expanded(
                      child: Text(e[tableHeaders[0]],textAlign: TextAlign.start,style: const TextStyle(color: Colors.white,fontSize: 16),softWrap:true,)),
                  Expanded(
                      child: Align(alignment: Alignment.center,child: Text(e[tableHeaders[1]].toString(),style: const TextStyle(color: Colors.white,fontSize: 16),softWrap:true,))),
                  Expanded(
                      child: Align(alignment:Alignment.topRight,child: Text(e[tableHeaders[2]],textAlign: TextAlign.end,style: TextStyle(
                            color: !indicatorLabels.contains(e[tableHeaders[2]]) ? const Color.fromARGB(100,255, 255, 255) : indicatorColors[indicatorLabels.indexOf(e[tableHeaders[2]])],
                            fontSize: 16
                        ),
                        softWrap:true,
                      ))),
                ],
              )
          ),
        ]
    ),).toList();
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Table(
      children: [
        // Table Header
        tableHeaders.isNotEmpty ? TableRow(
            decoration: BoxDecoration(
              color: const Color(0xff121212),
              borderRadius: BorderRadius.circular(7),
            ),
            children: [
              Container(
                  padding:EdgeInsets.symmetric(vertical: h*0.01,horizontal: w*0.07),
                  width:w,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tableHeaders.map((e) => Text(e,style: const TextStyle(fontSize: 14,color: Color.fromRGBO(255, 255, 255, 0.6)),)).toList(),
                  )
              ),
            ]
        ):TableRow(children: [Container()]),

        TableRow(children: [SizedBox(height: h*0.025,)]),

        // Table Body
        ...getTableBody(h, w),
      ],
    );
  }
}
