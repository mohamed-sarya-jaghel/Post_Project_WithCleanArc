import 'features/posts/data/datasoruces/post_local_data_sorucse.dart';
import 'features/posts/data/repositores/post_repositores_impl.dart';
import 'features/posts/domain/repositories/posts_repositories.dart';

import 'core/network/network_info.dart';
import 'features/posts/data/datasoruces/post_remote_data_sorucse.dart';

import 'features/posts/domain/usecases/add_post.dart';
import 'features/posts/domain/usecases/delete_post.dart';
import 'features/posts/domain/usecases/get_all_posts.dart';
import 'features/posts/domain/usecases/update_post.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getallposts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));

// Usecases

  sl.registerLazySingleton(() => getAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepositoriesInDomain>(() =>
      PostsRepositoriesImpl(
          remoteDataSource: sl(), locallDataSource: sl(), netWorkInfo: sl()));
// Datasources

  sl.registerLazySingleton<RemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => PostLocalDataSoruceImpl(sharedPreferences: sl()));

// Core

  sl.registerLazySingleton<NetWorkInfo>(() => NetWorkInfoImpl(sl()));

// External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
