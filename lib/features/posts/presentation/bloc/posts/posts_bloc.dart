// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:clean_arc_2023_1/core/error/faulures.dart';
import 'package:clean_arc_2023_1/features/posts/domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/strings/failures.dart';
import '../../../domain/enttites/post.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final getAllPostsUseCase getallposts;
  PostsBloc({required this.getallposts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());

        final failureOrPosts = await getallposts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getallposts();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }
  // من اجل معرفة نوع الذي سيرجعه لانو يرجع ايزر اما ليفت او ريت ( وهي من مكتبةدارتزfold)تم استخدام ال
  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      //left
      (failure) => ErrorPostsState(message: _mapFailureToMessage(failure)),
      //right
      (posts) => LoadedPostsState(
        posts: posts,
      ),
    );
  }

//تم وضعها من اجل معرفة الرسالة التي يجب كتبابتها اي معرفة نوع الخطا الذي حصل
  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        //في حال كان الخطا ليس مما سبق
        return "Unexpected Error , Please try again later .";
    }
  }
}
