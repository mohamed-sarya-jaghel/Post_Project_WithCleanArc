import 'package:dartz/dartz.dart';

import '../../../../core/error/faulures.dart';
import '../enttites/post.dart';

//خليناه ابستراكت لانو مشترك بين طبقتين وكذلك في طبعة ال دادتا يوجد ريبوسيتوريس بتعممل امبليمينت لهي الريبوسيتوؤيس
abstract class PostsRepositoriesInDomain {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}
