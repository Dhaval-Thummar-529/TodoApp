class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String? status;

  TodoModel({this.id, required this.title, required this.description, this.status});

  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        status = res['status'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status
    };
  }
}
