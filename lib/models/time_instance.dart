
class TimeInstance{

  final String timeInstance;
  final String summaryText;
  final MovingAverages movingAverages;
  final Oscillators oscillators;
  final List<PivotPoints> pivotPoints;

  TimeInstance({required this.summaryText, required this.timeInstance, required this.movingAverages, required this.pivotPoints, required this.oscillators});

  factory TimeInstance.fromJson(String instance, Map<String,dynamic> json){

    List<PivotPoints> pivList = [];
    Map<String,dynamic> temp = json['pivot_points'];

    temp.forEach((key, value) {
      pivList.add(PivotPoints.fromJson(key.toString(), value));
    });

    return TimeInstance(
      timeInstance: instance,
      summaryText: json['summary']['summary_text'].toString(),
      movingAverages: MovingAverages.fromJson('Moving Averages', json['moving_averages']),
      pivotPoints: pivList,
      oscillators: Oscillators.fromJson('Oscillators', json['technical_indicator']),
    );
  }
}

class MovingAverages{
  final String componentName;
  final Map<String,String> data;
  final List<TableData> tableData;

  MovingAverages({required this.componentName, required this.data, required this.tableData});

  factory MovingAverages.fromJson(String name,Map<String,dynamic> data){

    List<TableData> tData=[];
    Map<String,String> d={};

    data.forEach((key, value) {
      if(key.toString().compareTo('table_data')==0){

        Map<String,dynamic> tD = data['table_data'];
        tD.forEach((k, v) {
          tData.add(TableData.fromJson(k.toString(), v));
        });

      }else{
        d.addAll({key.toString():value.toString()});
      }
    });

    return MovingAverages(
        componentName: name,
        data: d,
        tableData: tData,
    );
  }
}

class TableData{
  final String title;
  final List<Map<String,String>> data;

  TableData({required this.title, required this.data});

  factory TableData.fromJson(String t, List<dynamic> d){

    List<Map<String,String>> mpList=[];

    for(int i=0;i<d.length;i++){
      Map<String,String> mp = {};
      Map temp = d[i];
      temp.forEach((key, value) {
        mp.addAll({key.toString():value.toString()});
      });
      mpList.add(mp);
    }


    return TableData(
        title: t,
        data: mpList,
    );
  }


}

class PivotPoints{
  final String title;
  final Map<String,String> points;

  PivotPoints({required this.title, required this.points});

  factory PivotPoints.fromJson(String t,Map p){

    Map<String,String> mp = {};
    p.forEach((key, value) {
      mp.addAll({key.toString():value.toString()});
    });

    return PivotPoints(
        title: t,
        points: mp,
    );
  }

}

class Oscillators{
  final String componentName;
  final Map<String,String> data;
  final List<Map<String,String>> tableData;

  Oscillators({required this.componentName, required this.data, required this.tableData});

  factory Oscillators.fromJson(String name,Map<String,dynamic>data){

    List<Map<String,String>> tData=[];
    Map<String,String> d={};

    data.forEach((key, value) {
      if(key.toString().compareTo('table_data')==0){

        for(int i=0;i<value.length;i++){
          Map<String,String> mp={};
          Map temp = value[i];
          temp.forEach((k, v) {
            mp.addAll({k.toString():v.toString()});
          });
          tData.add(mp);
        }

      }else{
        d.addAll({key.toString():value.toString()});
      }
    });

    return Oscillators(
        componentName: name,
        data: d,
        tableData: tData,
    );
  }


}