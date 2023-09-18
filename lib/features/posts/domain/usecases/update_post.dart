import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/faulures.dart';
import '../enttites/post.dart';

class UpdatePostUseCase {
  final PostsRepositoriesInDomain repositories;

  UpdatePostUseCase(this.repositories);
  Future<Either<Failure, Unit>> call(Post post) async {
    return await repositories.updatePost(post);
  }
}
