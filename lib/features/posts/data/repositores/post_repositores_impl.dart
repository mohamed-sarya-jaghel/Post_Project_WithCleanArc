// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:clean_arc_2023_1/core/error/faulures.dart';
import 'package:clean_arc_2023_1/core/network/network_info.dart';
import 'package:clean_arc_2023_1/features/posts/data/models/post_mode.dart';
import 'package:clean_arc_2023_1/features/posts/domain/enttites/post.dart';
import 'package:clean_arc_2023_1/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../datasoruces/post_local_data_sorucse.dart';
import '../datasoruces/post_remote_data_sorucse.dart';

class PostsRepositoriesImpl
    implements PostsRepositoriesInDomain //(الموجودة في ال دوامين)
{
  final RemoteDataSource remoteDataSource;
  final LocalDataSource locallDataSource;
  final NetWorkInfo netWorkInfo;

  PostsRepositoriesImpl({
    required this.remoteDataSource,
    required this.locallDataSource,
    required this.netWorkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await netWorkInfo.IsConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPost();
        //من اجل حفظ البوستات بعد جلبنها من النت في الذاكرة
        locallDataSource.cachePost(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await locallDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    //البوست هون على شكل امتتي يجب تحويله الة مودل
    final PostModel postModel =
        PostModel( title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() deleteOrUpdateOrAddPost) async {
    if (await netWorkInfo.IsConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
