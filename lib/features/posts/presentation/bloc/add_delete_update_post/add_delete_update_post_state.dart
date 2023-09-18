// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors_in_immutables
part of 'add_delete_update_post_bloc.dart';

sealed class AddDeleteUpdatePostState extends Equatable {
  const AddDeleteUpdatePostState();

  @override
  List<Object> get props => [];
}

//1
final class AddDeleteUpdatePostInitial extends AddDeleteUpdatePostState {}
//...................................................................................
//2
class LoadingAddDeleteUpdateState extends AddDeleteUpdatePostState {}
//3
class MessageAddDeleteUpdateState extends AddDeleteUpdatePostState {
  final String message;
  MessageAddDeleteUpdateState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
//4
class ErrorAddDeleteUpdateState extends AddDeleteUpdatePostState {
  final String message;

  ErrorAddDeleteUpdateState({required this.message});
  @override
  List<Object> get props => [message];
}
