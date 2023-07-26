import 'package:firebase_instagram/utils/colors.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10
      ),
      child: Column(
        children: [
          // HEADER SECTION
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16
            ).copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/placeholder.png'),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ),
                IconButton(onPressed: (){
                  showDialog(context: context, builder: (context) => Dialog(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16,),
                      shrinkWrap: true,
                      children: [
                        '게시글 삭제'
                      ].map((e) => InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Text(e),
                          ),
                        )
                      ).toList(),
                    )
                  ));
                }, icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          
          // IMAGE SECTION
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35 ,
            width: double.infinity,
            child: Image.network('https://plus.unsplash.com/premium_photo-1690297971162-5fe7ddf2c48d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=916&q=80',
              fit: BoxFit.cover,
            ),
          ),
          
          // LIKE COMMENT SECTION
          Row(
            children: [
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.comment_outlined,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.send,
                ),
              ),
              Expanded(child:Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.bookmark_border),
                  onPressed: (){},
                ),
              ))
            ],
          ),

          //DESCRIPTION AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800),
                    child: Text('좋아요 123개', style: Theme.of(context).textTheme.bodyText2,),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top:  8
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: primaryColor),
                      children: [
                        TextSpan(
                          text: 'username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'description',
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text('200개의 댓글 모두 보기', style: const TextStyle(
                      fontSize: 16,
                      color: secondaryColor
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('23년 7월 26일', style: const TextStyle(
                      fontSize: 16,
                      color: secondaryColor
                  ),
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
