// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:clean_arc_2023_1/core/error/exception.dart';
import 'package:clean_arc_2023_1/features/posts/data/models/post_mode.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart ' as http;

// هذا الكلاس خلناه ابستراكت مشان اذا مثلا خربت الديو يروح لحاله يعمل امبليمنت لل اتش تيتيبي بدون اخطاء
abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPost() async {
    final response = await client.get(Uri.parse(BASE_URL + "/posts/"),
        headers: {"Content_Type": "application/json"});
    if (response.statusCode == 200) {
      //هي تعتبر (LIST OF MAP)
//هذا الريسبونس سياتي على شكل جسون لذلك نستخدم ديكود
      final List decodedJson = jsonDecode(response.body) as List;
      // (LIST OF postModel)الى (LIST OF MAP) بنحول

      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {"title": postModel.title, "body": postModel.body};
    final response = await client.post(
        Uri.parse(
          BASE_URL + "/posts/",
        ),
        body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse(
          BASE_URL + "/posts/${postId.toString()}",
        ),
        headers: {"Content_Type": "application/json"});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {"title": postModel.title, "body": postModel.body};
    final response = await client.patch(
        Uri.parse(
          BASE_URL + "/posts/${postId.toString()}",
        ),
        body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
