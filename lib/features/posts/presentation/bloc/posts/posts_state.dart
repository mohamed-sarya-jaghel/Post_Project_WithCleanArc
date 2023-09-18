// ignore_for_file: prefer_const_constructors_in_immutables

part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}
//--------------------------------------------------
class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<Post> posts;

  LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String message;

  ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];
}
