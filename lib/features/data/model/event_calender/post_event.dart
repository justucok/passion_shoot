class PostEvent {
  final int? id; // Gunakan tipe data nullable untuk id
  final String date;
  final String title;
  final String time;

  PostEvent({
    this.id, // Jadikan id menjadi nullable
    required this.date,
    required this.title,
    required this.time,
  });

  factory PostEvent.fromJson(Map<String, dynamic> json) {
    return PostEvent(
      id: json['id'], // Tambahkan penanganan nilai null untuk id
      date: json['date'],
      title: json['title'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Tambahkan penanganan nilai null untuk id
      'date': date,
      'title': title,
      'time': time,
    };
  }
}
