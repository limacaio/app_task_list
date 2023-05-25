class Task {
  Task({required this.title, required this.date});
  Task.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = DateTime.parse(json['datetime']);

  late String title;
  late DateTime date;

  //tranformando obj em json
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'datetime': date.toIso8601String(),
    };
  }
}
