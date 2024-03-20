import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/comments/comments_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentsPage extends GetView<CommentsController> {
  const CommentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Comentarios',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title: TextFormField(
                      controller: controller.commentTextEditingController,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "Faça um comentario",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.saveNewCommentToDatabase();

                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                        itemCount: controller.listOfComments.length,
                        itemBuilder: (context, index) {
                          final eachCommentInfo = controller.listOfComments[index];

                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2, bottom: 2),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    backgroundImage: NetworkImage(
                                      eachCommentInfo.userProfileImage.toString(),
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        eachCommentInfo.userName.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        eachCommentInfo.commentText.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      InkWell(
                                        onTap: () {
                                          controller.deleteComment(
                                            eachCommentInfo.commentID.toString(),
                                          );
                                        },
                                        child: const Text(
                                          'Apagar Comentario',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                    ],
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(
                                        tago.format(eachCommentInfo.publishedDateTime!, locale: 'pt_BR'),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        ' ${eachCommentInfo.commentLikesList!.length.toString()} Likes',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      controller.likeUnLikeComment(eachCommentInfo.commentID.toString());
                                    },
                                    icon: Icon(
                                      eachCommentInfo.commentLikesList!.contains(controller.uid)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 30,
                                      color: eachCommentInfo.commentLikesList!.contains(controller.uid)
                                          ? Colors.red
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
