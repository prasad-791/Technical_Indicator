import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OptionSelector extends StatefulWidget {

  final String defaultValue;
  final List<String> options;
  final ValueChanged<String> selectedOption;
  const OptionSelector({Key? key, required this.defaultValue, required this.options, required this.selectedOption}) : super(key: key);

  @override
  _OptionSelectorState createState() => _OptionSelectorState();
}

class _OptionSelectorState extends State<OptionSelector> {

  Color bgColor = const Color(0xff121212);
  Color color = const Color.fromRGBO(255, 255, 255, 0.6);
  Color unselectedColor = const Color.fromRGBO(255,255,255,0.4);
  int selectedOptionIndex = 0;

  List<Widget> buildOptions(var w){
    return widget.options.map((e) => GestureDetector(
      onTap: (){
        setState(() {
          selectedOptionIndex = widget.options.indexOf(e.toString());
        });
        widget.selectedOption(e);
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.check,color: selectedOptionIndex == widget.options.indexOf(e) ? color : Colors.transparent,),
              SizedBox(width: w*0.05,),
              Text(e,style: TextStyle(
                  color: selectedOptionIndex == widget.options.indexOf(e) ? color : unselectedColor,
                  fontSize: 17
              ),),
            ],
          ),
          const SizedBox(height: 20,),
        ]
      ),
    )).toList();
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        if(widget.options.isNotEmpty){
          showMaterialModalBottomSheet(isDismissible:true,backgroundColor: Colors.transparent,context: context, builder: (context)=>Container(
            padding: EdgeInsets.only(top: h*0.05,bottom: h*0.01,left: w*0.05,right: w*0.05),
            constraints: BoxConstraints(
              maxHeight: h*0.3,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...buildOptions(w),
                ],
              ),
            ),
          ));
        }
      },
      child: Container(
        // width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: w*0.07,vertical: h*0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.defaultValue,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: color),),
            Icon(Icons.keyboard_arrow_down_rounded,size: 17,color: color,),
          ],
        ),
      ),
    );
  }
}
