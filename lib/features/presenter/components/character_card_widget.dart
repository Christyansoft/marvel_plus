import 'package:flutter/material.dart';

class CharacterCardWidget extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CharacterCardWidget({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      child: Row(
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
