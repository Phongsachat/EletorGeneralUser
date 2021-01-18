import 'package:Eletor/ui/comment/comment_view.dart';
import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/constants.dart';
import 'package:Eletor/widgets/mission/messages_comment.dart';
import 'package:Eletor/widgets/text/head_text.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsCard extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final int blurRadius;
  final int spreadRadius;
  final bool haveAnyComment;
  final String text;
  final int commentLength;
  final List<List<String>> comments;

  const CommentsCard(
      {Key key,
      this.width,
      this.height,
      this.text,
      this.radius,
      this.blurRadius,
      this.spreadRadius,
      this.commentLength,
       this.haveAnyComment,
      @required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: (){
        Get.to(CommentView(),transition: Transition.downToUp);
      },
      child: Container(
        width: width ?? size.width * 0.8,
        height: height,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: blurRadius ?? 5, spreadRadius: spreadRadius ?? 0.5)],
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(padding: EdgeInsets.only(left: size.width * 0.06, top: size.height * 0.01), child: HeaderText(title: StringValue.comment)),
            (haveAnyComment)? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 //  for(var comment in comments)  _commentsBox((comments.length > 0)? comment[0]: "", (comments.length > 0)? comment[1]: ""),
                  _commentsBox((comments.length > 0)? comments[0][0]: "", (comments.length > 0)? comments[0][1]: "") ,
                  (comments.length == 2) ? _commentsBox((comments.length > 0)? comments[1][0]: "", (comments.length > 0)? comments[1][1]: "") : Container(),
                  Container(margin: const EdgeInsets.only(left: 21, right: 21),
                    padding: const EdgeInsets.only(left: 5, top: 2, right: 5, bottom: 3),
                    child: ((commentLength - 2) > 0) ?  _moreComments(commentLength)  : Container(),)
                ],
            ) : InkWell(onTap: (){ Get.to(CommentView(),transition: Transition.downToUp);},child: _haveNoAnyComment(height,width)),
          ],
        ),
      ),
    );
  }

  Widget _commentsBox(String _userName, String _comment) {
    return Container(
      margin: const EdgeInsets.only(left: 21, right: 21),
      padding: const EdgeInsets.only(left: 5, top: 3, right: 5, bottom: 3),
      child: MessagesComment(
        userName: _userName,
        comment: _comment,
      ),
    );
  }

  Widget _moreComments(int length) {
    return AutoSizeText(StringValue.entire_comment + " ${length - 2} " + StringValue.list,
        style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontFamily: primaryFontFamily));
  }

  Widget _haveNoAnyComment(double height,double width){
    return Container(
      margin: EdgeInsets.only(left: width * 0.08,right: width * 0.08,top: 5),
      height: height * 0.65,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(margin: EdgeInsets.only(right: 10),child: Icon(Icons.forum_outlined,size: 30,color: Colors.grey,)),
          AutoSizeText(StringValue.expression,
          style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontFamily: primaryFontFamily)
          ),
      Container(
        child: AutoSizeText(StringValue.tripleDot,
          style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
              fontFamily: primaryFontFamily)),
      )
        ],
      ),
    );
  }
}
