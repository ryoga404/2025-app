import 'package:flutter/material.dart';
import 'package:web_browser/node/node.dart';

class NodeWidget extends StatelessWidget {
  final Node node;
  final VoidCallback? onTap;

  const NodeWidget({
    super.key,
    required this.node,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(node.name),
      ),
    );
  }
}