// ignore_for_file: prefer_final_fields

import 'package:clean_arc_2023_1/features/posts/presentation/pages/widgets/textform_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enttites/post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'form_submit.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({
    Key? key,
    required this.isUpdatePost,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    //اول شي عم نتاكد انو يصلح يعني ليس فارغ
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      //لازم هون اعرف شو هو الايفينتيلي لازم ابعته ايديت او اد؟
      final post = Post(

          //PostEmttiesلانو بحالة الاضافة انا لست بحاجة الى معرفة ال اي دي تبع البوست المضاف لذلك بال null تساوي (ID)جعلنا قيمة ال
          //وكمان غيرنا الباقي بالدوماين والداتا) null وحطينا اشارة ؟ لنقدر نحط هون
          id: widget.isUpdatePost ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
