import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/core/extensions/interger.extension.dart';
import 'package:todo_list/feature/domain/entities/todo_entity.dart';
import 'package:todo_list/feature/domain/mapper/mapper.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel implements Transfer<TodoEntity> {
  final int? id;
  final String? title;
  final String? description;
  final int? status;
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;
  @JsonKey(name: 'create_at')
  final DateTime? createdAt;
  @JsonKey(name: 'update_at')
  final DateTime? updatedAt;

  TodoModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  @override
  TodoEntity transfer() => TodoEntity(
        id: id,
        title: title != null && title!.isNotEmpty ? title : null,
        description:
            description != null && description!.isNotEmpty ? description : null,
        status: status != null ? status!.toBool() : false,
        dueDate: dueDate,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
