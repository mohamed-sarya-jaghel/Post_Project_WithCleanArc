import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
//(injection)لو ما عملنا ال
//كان هاد الكلام كلو لازم نكتبو ولسا اكتر على البلوك التاني
          //  PostsBloc(
          //     getallposts: getAllPostsUseCase(PostsRepositoriesImpl(
          //         remoteDataSource:PostRemoteDataSourceImpl(client:sharedPreferences ),
          //         locallDataSource: PostLocalDataSoruceImpl(sharedPreferences:Client ),,
          //         netWorkInfo: NetWorkInfoImpl(InternetConnectionChecker())))),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Posts App',
            home: PostsPage()));
  }
}
