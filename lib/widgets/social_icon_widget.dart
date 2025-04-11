import 'package:flutter/material.dart';

class SocialIconWidget extends StatefulWidget {
  final String assetPath;

  const SocialIconWidget({super.key, required this.assetPath});

  @override
  State<SocialIconWidget> createState() => _SocialIconWidgetState();
}

class _SocialIconWidgetState extends State<SocialIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Image.network(
        widget.assetPath,
        height: 30,
        width: 30,
      ),
    );
  }
}
