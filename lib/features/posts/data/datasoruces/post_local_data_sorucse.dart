// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:clean_arc_2023_1/core/error/exception.dart';
import 'package:clean_arc_2023_1/features/posts/data/models/post_mode.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  //بحاجة الى فنكشن عدد 2 الاول يحفظ البوستات بالجهاز والقاني يرجع البوستات المحفوظة

  //ارجاع البوستات
  Future<List<PostModel>> getCachedPosts();
  //حفظ البوستات
  Future<Unit> cachePost(List<PostModel> postModel);
}

const CACHED_POSTS = "CACHED_POSTS";

class PostLocalDataSoruceImpl implements LocalDataSource {
  SharedPreferences sharedPreferences;
  PostLocalDataSoruceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<Unit> cachePost(List<PostModel> postModel) {
//لكي يتم تخزينها في الجهاز(Map) الى (List<PostModel> )يجب تحويل
    List PostModelsToJson = postModel
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    //الان يجب حفظ البوستات
    sharedPreferences.setString(CACHED_POSTS, jsonEncode(PostModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    //---------------------------------------------------------------------------------
    //              لم افهمها (الفيدو   رقم 9 )
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      //هي تعتبر (LIST OF MAP)
      List decodeJsonData = jsonDecode(jsonString);
      // (LIST OF postModel)الى (LIST OF MAP) بنحول
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
