
class BuildTaskModel {
  final int id;
  final String title;
  final String date;
  final String startTime;
  final String endTime;
  final String remind;
  final int color;
  final int completed;
  final int favorites;

  BuildTaskModel({
    required this.id,
    required this.color,
    required this.completed,
    required this.favorites,
    required this.date,
    required this.endTime,
    required this.title,
    required this.startTime,
    required this.remind,
  });
  factory BuildTaskModel.fromJson(Map<String, dynamic> json) {
    return BuildTaskModel(
      id: json['id'] as int,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      remind: json['remind'] as String,
      title: json['title'] as String,
      endTime: json['endTime'] as String,
      color: json['color'] as int,
      completed: json['completed'] as int,
      favorites: json['favorites'] as int,
    );
  }
}
