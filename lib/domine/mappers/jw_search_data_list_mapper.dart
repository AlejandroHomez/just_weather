import 'package:just_weather_app/just_weather.dart';

class JwSearchDataListMapper extends Mapper<JwSearchDataListModel> {
  @override
  JwSearchDataListModel fromMap(Map<String, dynamic> json) {
    List<dynamic> dataList = json['data'];
    return JwSearchDataListModel(
      searchDataList: dataList
          .map((item) => JwSearchResponseMapper().fromMap(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toMap(JwSearchDataListModel data) {
    return {'searchDataList': data.searchDataList};
  }
}
