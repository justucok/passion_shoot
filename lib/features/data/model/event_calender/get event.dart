class GetEvent {
  final String id;
  final String date;
  final String title;
  final String time;

  GetEvent({
    required this.id,
    required this.date,
    required this.title,
    required this.time,
  });

  factory GetEvent.fromJson(Map<String, dynamic> json) {
    return GetEvent(
      id: json['id'].toString(),
      date: json['date'],
      title: json['title'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'time': time,
    };
  }
}
