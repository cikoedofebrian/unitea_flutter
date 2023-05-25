import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/comment.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.data});

  final Comment data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.senderName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              DateFormat('dd/MM/yyy').format(data.createdAt),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(data.content),
        const Divider(color: Colors.grey),
      ],
    );
  }
}
