import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unitea_flutter/constants/colors.dart';
import 'package:unitea_flutter/models/post.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.data});
  final Post data;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primary,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 4,
              color: Colors.black38,
            )
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'by ${data.senderName}',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  data.facultyName,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"${data.title}"',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(data.createdAt),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(240, 240, 240, 1)),
                          child: Row(children: [
                            const Icon(
                              Icons.thumb_up,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(data.likes.toString())
                          ]),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromRGBO(240, 240, 240, 1)),
                          child: Row(children: [
                            const Icon(
                              Icons.comment,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(data.comments.toString())
                          ]),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
