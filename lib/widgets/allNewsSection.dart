// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AllNewsSection extends StatelessWidget {
  String image, desc, title;
  AllNewsSection({
    Key? key,
    required this.image,
    required this.desc,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
            maxLines: 2,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            desc,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w500,
                fontSize: 16),
            maxLines: 3,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}