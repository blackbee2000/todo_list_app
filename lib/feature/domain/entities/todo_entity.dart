class TodoEntity {
  final int? id;
  final String? title;
  final String? description;
  final bool status;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TodoEntity({
    this.id,
    this.title,
    this.description,
    this.status = false,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  TodoEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? status,
    DateTime? dueDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TodoEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        dueDate: dueDate ?? this.dueDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toMapCreate() {
    return {
      'title': title,
      'description': description,
      'status': status ? 1 : 0,
      'due_date': dueDate?.toIso8601String(),
      'create_at': createdAt?.toIso8601String(),
      'update_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toMapUpdate() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status ? 1 : 0,
      'due_date': dueDate?.toIso8601String(),
      'create_at': createdAt?.toIso8601String(),
      'update_at': updatedAt?.toIso8601String(),
    };
  }
}
