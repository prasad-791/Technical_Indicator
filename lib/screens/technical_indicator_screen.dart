import 'package:flutter/material.dart';
import 'package:technical_indicator/models/time_instance.dart';
import 'package:technical_indicator/services/api_service.dart';
import 'package:technical_indicator/widgets/information_component.dart';
import 'package:technical_indicator/widgets/linear_indicator.dart';
import 'package:technical_indicator/widgets/option_selector.dart';
import 'package:technical_indicator/configurations/config.dart';

class TechnicalIndicator extends StatefulWidget {

  static const routeName = '/technical_indicator';

  const TechnicalIndicator({Key? key}) : super(key: key);

  @override
  _TechnicalIndicatorState createState() => _TechnicalIndicatorState();
}

class _TechnicalIndicatorState extends State<TechnicalIndicator> {

  int pivIndex = 0;

  List<TimeInstance> timeInstanceList = [];
  late TimeInstance selectedInstance = TimeInstance(
      summaryText: '',
      timeInstance: '',
      movingAverages: MovingAverages(
        componentName: '',
        data: {},
        tableData: [],
      ),
      pivotPoints: [],
      oscillators: Oscillators(
        componentName: '',
        data: {},
        tableData: [],
      )
  );

  bool isVisible = false;
  
  // Header for each part
  Widget buildHeader(String val){
    return Align(
      alignment: Alignment.center,
      child: Text(val,style: const TextStyle(color: Colors.white,fontSize: 18),),
    );
  }

  // Summary Container starts

  Color selectedTimeInstance = Colors.white;
  Color unSelectedTimeInstance = const Color.fromARGB(100, 255, 255, 255);
  

  int index = 0;
  int selectedIndex = 0;

  Widget timeInstance(String val,var h,var w,Color color){
    return Container(
      width: w*0.2,
      margin: EdgeInsets.symmetric(vertical: h*0.01),
      padding: EdgeInsets.symmetric(horizontal: w*0.02,vertical: h*0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Center(
        child: Text(val,style: TextStyle(
          fontSize: 14,
          color: color,
        ),),
      ),
    );
  }

  List<Widget> getInstances(var h,var w){
    return timeInstances.map((e) => GestureDetector(
        onTap: (){
          setState(() {
            selectedIndex = timeInstances.indexOf(e);
            setCurrentTimeInstance(selectedIndex);
            index = indicatorLabels.indexOf(selectedInstance.summaryText.toUpperCase());
          });
        },
        child: timeInstance(e, h, w,selectedIndex == timeInstances.indexOf(e)?selectedTimeInstance:unSelectedTimeInstance))).toList();
  }

  Widget timeInstancesContainer(var h, var w){
    return Container(
      margin: EdgeInsets.only(right: w*0.05,left: w*0.12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearIndicator(index: index),
          Column(
            children: getInstances(h, w),
          )
        ],
      ),
    );
  }

  Widget buildSummaryContainer(var h,var w){
    return Column(
      children: [
        buildHeader("Summary"),
        SizedBox(height: h*0.03,),
        timeInstancesContainer(h, w),
      ],
    );
  }
  // Summary Container ends

  // Info Component

  List<String> tableHeaders = [
    "Period",
    "Value",
    "Type"
  ];

  List tableBody = [
    {
      "Period" : "MA10",
      "Value" : 465.28,
      "Type" : "SELL",
    },
    {
      "Period" : "MA20",
      "Value" : 465.28,
      "Type" : "SELL",
    },
    {
      "Period" : "MA30",
      "Value" : 465.28,
      "Type" : "BUY",
    },
    {
      "Period" : "MA50",
      "Value" : 465.28,
      "Type" : "BUY",
    },
    {
      "Period" : "MA100",
      "Value" : 465.28,
      "Type" : "SELL",
    },
    {
      "Period" : "MA200",
      "Value" : 465.28,
      "Type" : "BUY",
    },
  ];

  List<String> tableHeaders2 = [
    "Name",
    "Value",
    "Action"
  ];

  List tableBody2 = [
    {
      "Name" : "RSI(14)",
      "Value" : -53.6549,
      "Action" : "NEUTRAL",
    },
    {
      "Name" : "CCI(20)",
      "Value" : -53.6549,
      "Action" : "SELL",
    },
    {
      "Name" : "ADI(14)",
      "Value" : -53.6549,
      "Action" : "BUY",
    },
    {
      "Name" : "Awesome Oscillator",
      "Value" : -53.6549,
      "Action" : "SELL",
    },
    {
      "Name" : "Momentum(10)",
      "Value" : -53.6549,
      "Action" : "SELL",
    },
    {
      "Name" : "Stochastic RSI Fast(3,3,14,14)",
      "Value" : -53.6549,
      "Action" : "SELL",
    },
    {
      "Name" : "Williams %R(14)",
      "Value" : -53.6549,
      "Action" : "SELL",
    },
    {
      "Name" : "Bull Bear Power",
      "Value" : -53.6549,
      "Action" : "SELL",
    },
    {
      "Name" : "Ultimate Oscillator(7,14,28)",
      "Value" : -53.6549,
      "Action" : "LESS VOLATILE",
    },
  ];

  Map<String,String> infoRowList = {
    "Buy": 7.toString(),
    "Neutral": "-",
    "Sell": 10.toString(),
  };

  // Info Component

  // Pivot Point Component
  Map pivPoint = {
    "S3": 456.87.toString(),
    "S2": 456.87.toString(),
    "S1": 456.87.toString(),
    "Pivot Points": 456.87.toString(),
    "R1": 456.87.toString(),
    "R2": 456.87.toString(),
    "R3": 456.87.toString(),
  };

  List<Widget> buildPivotRows(var h,var w){
    List<Widget> tempList = [];

    if(selectedInstance.pivotPoints.isNotEmpty){
      selectedInstance.pivotPoints[pivIndex].points.forEach((key, value) {
        tempList.add(Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.08,vertical: h*0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(key,style: TextStyle(fontSize: 16,color: unSelectedTimeInstance),),
              Text(value,style: const TextStyle(fontSize: 16,color: Colors.white),),
            ],
          ),
        ));
      });
    }

    return tempList;
  }

  Widget buildPivotPointsComponent(var h, var w){
    return Column(
      children: [
        buildHeader("Pivot Points"),
        SizedBox(height: h*0.02,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: w*0.25),
          child: OptionSelector(defaultValue: selectedInstance.pivotPoints.isNotEmpty?selectedInstance.pivotPoints[pivIndex].title:"", options: [
            ...selectedInstance.pivotPoints.map((e) => e.title).toList(),
          ], selectedOption: (val){
              setState(() {
                pivIndex = selectedInstance.pivotPoints.indexWhere((element) => element.title == val);
              });
          }),
        ),
        SizedBox(height: h*0.02,),
        ...buildPivotRows(h,w),
      ],
    );
  }
  // Pivot Point Component

  List<String> getMovingAveragesTableOptions(){
    if(selectedInstance.movingAverages.tableData.isNotEmpty){
      return selectedInstance.movingAverages.tableData.map((e) => e.title).toList();
    }else{
      return [];
    }
  }

  List<Map<String,List<String>>> getOscillatorTableData(){
    List<Map<String,List<String>>> temp = [];

    List<String> column1 = [];
    List<String> column2 = [];
    List<String> column3 = [];

    selectedInstance.oscillators.tableData.forEach((element) {
      element.forEach((key, value) {
        if(key.compareTo('name')==0){
          column1.add(value);
        }else if(key.compareTo('value')==0){
          column2.add(value);
        }else if(key.compareTo('action')==0){
          column3.add(value);
        }
      });
    });

    temp.add({"Name":column1});
    temp.add({"Value":column2});
    temp.add({"Action":column3});

    return temp;
  }

  Map<String,List<Map<String,List<String>>>> getMovingAveragesTableData(){

    Map<String,List<Map<String,List<String>>>> tempMP = {};

    selectedInstance.movingAverages.tableData.forEach((element) {

      List<Map<String,List<String>>> temp = [];

      List<String> column1 = [];
      List<String> column2 = [];
      List<String> column3 = [];

      element.data.forEach((e) {
        e.forEach((key, value) {
          if(key.compareTo('title')==0){
            column1.add(value);
          }else if(key.compareTo('value')==0){
            column2.add(value);
          }else if(key.compareTo('type')==0){
            column3.add(value);
          }
        });
      });

      temp.add({"Title":column1});
      temp.add({"Value":column2});
      temp.add({"Type":column3});

      tempMP.addAll({element.title:temp});
    });

    return tempMP;
  }

  void setCurrentTimeInstance(int ind){
    selectedInstance = timeInstanceList.firstWhere((element) => element.timeInstance == timeInstances[ind]);
  }

  void fetchData()async{

    setState(() {
      isVisible = false;
    });

    List<TimeInstance> temp = await ApiService().getData();
    setState(() {
      timeInstanceList = temp;
      setCurrentTimeInstance(selectedIndex);
      isVisible = true;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Row(
          children: [
            const Icon(Icons.arrow_back_ios_rounded,color: Colors.white,size: 15,),
            SizedBox(width: w*0.1,),
            const Text("USD/INR",style: TextStyle(fontWeight: FontWeight.w500),),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Visibility(
            visible: isVisible,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: h*0.01,),
                  Container(margin: EdgeInsets.symmetric(horizontal: w*0.05),child: OptionSelector(defaultValue: "Technical Indicators",options: const [],selectedOption: (val){

                  },)),
                  SizedBox(height: h*0.05,),
                  buildSummaryContainer(h, w),
                  SizedBox(height: h*0.05,),
                  InformationComponent(
                    tableData: getMovingAveragesTableData(),
                    options: getMovingAveragesTableOptions(),
                    title: selectedInstance.movingAverages.componentName,
                    tag: selectedInstance.movingAverages.data['text']??'',
                    infoRowList: selectedInstance.movingAverages.data.isNotEmpty?selectedInstance.movingAverages.data:{},
                  ),
                  SizedBox(height: h*0.05,),
                  InformationComponent(
                      tableData: getOscillatorTableData(),
                      options: const [],
                      title: selectedInstance.oscillators.componentName,
                      tag: selectedInstance.oscillators.data['text']??'',
                      infoRowList: selectedInstance.oscillators.data.isNotEmpty?selectedInstance.oscillators.data:{},
                  ),
                  SizedBox(height: h*0.05,),
                  buildPivotPointsComponent(h, w),
                  SizedBox(height: h*0.05,),
                ],
              ),
            ),
          ),
          Visibility(visible: !isVisible,child: const Center(child: CircularProgressIndicator(color: Colors.white,))),
        ],
      )
    );
  }
}
