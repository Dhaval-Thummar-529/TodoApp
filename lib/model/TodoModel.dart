class TodoModel {
  final int? id;
  final String title;
  final String description;
  final String? status;
  final String? startDate;
  final String? modifiedDate;
  final String? endDate;
  final int? progress;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.modifiedDate,
    required this.endDate,
    required this.progress,
  });

  TodoModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        status = res['status'],
        startDate = res['startDate'],
        modifiedDate = res['modifiedDate'],
        endDate = res['endDate'],
        progress = res['progress'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'startDate': startDate,
      'modifiedDate': modifiedDate,
      'endDate': endDate,
      'progress': progress };
  }
}
