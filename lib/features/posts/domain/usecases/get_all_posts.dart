// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arc_2023_1/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/faulures.dart';
import '../enttites/post.dart';

class getAllPostsUseCase {
  final PostsRepositoriesInDomain repository;
  getAllPostsUseCase(
    this.repository,
  );
  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
