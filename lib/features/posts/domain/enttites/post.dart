// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

//شيء مصغر عن المودل
class Post extends Equatable {
  final int? id;
  final String title;
  final String body;
  const Post({
   this.id,
    required this.title,
    required this.body,
  });
  @override
  List<Object?> get props => [id, title, body];
}
