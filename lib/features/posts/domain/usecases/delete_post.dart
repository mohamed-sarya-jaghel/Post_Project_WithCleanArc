import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/faulures.dart';

class DeletePostUseCase {
  final PostsRepositoriesInDomain repositories;

  DeletePostUseCase(this.repositories);
  Future<Either<Failure, Unit>> call(int postId) async {
    return await repositories.deletePost(postId);
  } 
}
