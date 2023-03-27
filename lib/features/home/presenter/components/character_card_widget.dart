import 'package:flutter/material.dart';

class CharacterCardWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final bool hasSeries;

  const CharacterCardWidget({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.hasSeries,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 16, left: 16, bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          description.isNotEmpty
                              ? description
                              : 'No description',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ),
                      Visibility(
                        visible: hasSeries,
                        child: Icon(
                          Icons.movie_filter,
                          size: 20,
                          color: Theme.of(context).primaryColor.withAlpha(80),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
