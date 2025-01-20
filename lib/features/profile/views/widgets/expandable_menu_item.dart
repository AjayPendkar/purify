import 'package:flutter/material.dart';

class ExpandableMenuItem extends StatefulWidget {
  final String title;
  final List<String> subItems;
  final Function() onTap;

  const ExpandableMenuItem({
    Key? key,
    required this.title,
    required this.subItems,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ExpandableMenuItem> createState() => _ExpandableMenuItemState();
}

class _ExpandableMenuItemState extends State<ExpandableMenuItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
            widget.onTap();
          },
        ),
        if (_isExpanded) ...[
          Container(
            color: Colors.grey[50],
            child: Column(
              children: widget.subItems.map((item) => 
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 32, right: 16),
                  title: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  onTap: () {
                    // Handle sub-item tap
                  },
                ),
              ).toList(),
            ),
          ),
        ],
        const Divider(height: 1),
      ],
    );
  }
} 