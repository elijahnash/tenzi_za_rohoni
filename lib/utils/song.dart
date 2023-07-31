class DataModel {
  final List<String> chorus;

  DataModel({required this.chorus});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(chorus: List<String>.from(json['chorus']));
  }
}
