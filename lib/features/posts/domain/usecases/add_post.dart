import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/faulures.dart';
import '../enttites/post.dart';

class AddPostUseCase {
  final PostsRepositoriesInDomain repositories;

  AddPostUseCase(this.repositories);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repositories.addPost(post);
  }
}
