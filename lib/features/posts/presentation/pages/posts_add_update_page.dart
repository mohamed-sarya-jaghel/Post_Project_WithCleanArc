// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:clean_arc_2023_1/core/widgets/loading_widget.dart';
import 'package:clean_arc_2023_1/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_arc_2023_1/features/posts/presentation/pages/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/snack_bar.dart';
import '../../domain/enttites/post.dart';

class PostAddUpdatePage extends StatelessWidget {
  // (Post emtties) اذا جاية بغرض التعديل لح يكون معك
  // (Post emtties) اذا جاية بغرض الاضافة فلن يكون فائدة لاحاجة لها
  final Post? post;
  //هذا المتحول لمعرفة اذا جاية بغؤض التعديل او الاضافة
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody() {
    // (Form Widget) لح رجعلو (inital state) اذا كانت
    //   لح نرجع لودينغ(LoadingState) وفي حال
    //    (Form Widget)باقي الحالات يلي هنن يعطي الرسالة انو مشي الحال او رسالة الايرور  كمان لح رجعلو ة
    //بالاضافة لليسنر لم يرجع انو اليوست انضاف لح اعرض سناك بار ونافيغات اما بالايرور ستات ماعم اعمل نافيغات لكن عم اتركه بنفس الصفحة بس عم طلعلو سناك با
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
            listener: (context, state) {
          if (state is MessageAddDeleteUpdateState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
          } else if (state is ErrorAddDeleteUpdateState) {
            SnackBarMessage()
                .showSuccessSnackBar(message: state.message, context: context);
          }
        }, builder: (context, state) {
          if (state is LoadingAddDeleteUpdateState) {
            return LoadingWidget();
          }
          return FormWidget(
              isUpdatePost: isUpdatePost, post: isUpdatePost ? post : null);
        }),
      ),
    );
  }
}
