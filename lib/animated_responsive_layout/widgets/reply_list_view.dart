
import 'package:flutter/material.dart';
import 'package:flutterHub/animated_responsive_layout/models/data.dart' as data;
import 'package:flutterHub/animated_responsive_layout/widgets/email_widget.dart';
class ReplyListView extends StatelessWidget {
  const ReplyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ListView(
        children: [
          const SizedBox(height: 8),
          ...List.generate(data.reepliies.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: EmailWidget(
                   isPreview: false,
                    isThreaded: true,
                    showHeadline: index == 0,
                    email: data.reepliies[index]),
              );
          })
        ],
      ),
    );
  }
}
