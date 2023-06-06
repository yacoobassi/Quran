import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_ro_run/Links.dart';
import 'package:test_ro_run/PagesWidgets/posts/post_publisher.dart';
import '../../User/Data.dart';
import '../../request.dart';
import '../../showImage.dart';
import 'addPost.dart';
import 'like_comment.dart';

int likes = 0, comments = 0;

class posts_body extends StatefulWidget {
  final Function showComments;
  posts_body({Key key, this.showComments}) : super(key: key);

  @override
  _PostsBodyState createState() => _PostsBodyState();
}

class _PostsBodyState extends State<posts_body>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  File _image;
  Requst request = Requst();

  Map<String, dynamic> _postData;

  void _setImage(File newImage) {
    setState(() {
      _image = newImage;
    });
  }

  Future<Map<String, dynamic>> _getPosts() async {
    final response = await request.postRequest(getPost, {
      "reginmentNum": Data.user.regiment,
      "instituteNum": Data.user.institute,
      "num": Data.user.email.replaceAll("@gmail.com", ""),
    });

    return response;
  }

  List<int> isLikedList = [];

  @override
  void initState() {
    super.initState();
    _getPosts().then((data) {
      setState(() {
        _postData = data;
      });

      for (var i = 0; i < _postData['count']; i++) {
        isLikedList.add(_postData['data'][i]['isLiked']);
      }
    });
  }

  Future<void> _refreshPosts() async {
    final data = await _getPosts();
    setState(() {
      _postData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_postData == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final data = _postData['data'];
    final count = _postData['count'];
    final plus = Data.user.student ? 0 : 1;

    return RefreshIndicator(
      onRefresh: _refreshPosts,
      child: ListView.separated(
        itemCount: count + plus,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 && !Data.user.student)
            return Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: AddPostScreen(
                _setImage,
                _refreshPosts,
                _image,
              ),
              color: Colors.white,
            );
          else {
            final post = data[index - plus];

            return Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  post_publisher(post['name'], post['date']),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10),
                    child: Text(post['comment']),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return showImage(
                              "http://192.168.1.101:8080/Quran/images/post/${post['image']}",
                              true);
                        }));
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://192.168.1.101:8080/Quran/images/post/${post['image']}",
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 20),
                  like_comment(
                      post['likesNum'],
                      post['commentsNum'],
                      post['count'],
                      _refreshPosts,
                      widget.showComments,
                      post["isLiked"]),
                ],
              ),
            );
          }
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
