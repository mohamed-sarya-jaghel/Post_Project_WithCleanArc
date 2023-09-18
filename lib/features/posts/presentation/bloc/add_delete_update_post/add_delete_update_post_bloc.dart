import 'package:bloc/bloc.dart';
import '../../../domain/usecases/add_post.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/error/faulures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/strings/message.dart';
import '../../../domain/enttites/post.dart';
part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      // (usecase ) لازم يجكي مع(event)كل
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdateState());
        //-----------------------------------------------
        final failureOrDoneMessage = await addPost(event.post);
        //نعمل فولد لانو ممكن يرجع فايلو او ينيت
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
        //-----------------------------------------------
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdateState());

        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
        //-----------------------------------------------
      } else if (event is DeletePostEvent) {
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(
            failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
  //-----------------------------------------------

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
        //left
        (failure) =>
            ErrorAddDeleteUpdateState(message: _mapFailureToMessage(failure)),
        //right
        (_) => MessageAddDeleteUpdateState(message: message));
  }
  //-----------------------------------------------

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
