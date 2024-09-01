import 'package:flutter/material.dart';
import 'package:flutterHub/animated_responsive_layout/models/data.dart';
import 'package:flutterHub/animated_responsive_layout/models/models.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/email_widget.dart';
import 'package:flutterHub/animated_responsive_layout/widgets/search_bar.dart'
    as sb;

class EmailListView extends StatelessWidget {
  const EmailListView(
      {super.key,
      this.selectedIndex,
      this.onSelected,
      required this.currentUser});

  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        sb.SearchBar(currentUser: currentUser),
        const SizedBox(height: 8),
        ...List.generate(emails.length, (index) {
          return EmailWidget(
              isSelected: selectedIndex == index,
              onSelected: onSelected != null
                  ? () {
                      onSelected!(index);
                    }
                  : null,
              email: emails[index]);
        }),
      ],
    );
  }
}
