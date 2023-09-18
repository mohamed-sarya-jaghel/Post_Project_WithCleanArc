// ignore_for_file: prefer_const_constructors_in_immutables

part of 'add_delete_update_post_bloc.dart';

sealed class AddDeleteUpdatePostEvent extends Equatable {
  const AddDeleteUpdatePostEvent();

  @override
  List<Object> get props => [];
}

//اضافة بوست
class AddPostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

//تعديل بوست
class UpdatePostEvent extends AddDeleteUpdatePostEvent {
  final Post post;

  UpdatePostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

//حذف بوست
class DeletePostEvent extends AddDeleteUpdatePostEvent {
  final int postId;

  DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
