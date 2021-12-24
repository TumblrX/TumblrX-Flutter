import 'package:flutter/material.dart';
import 'package:tumblrx/services/api_provider.dart';

class SquareAvatar extends StatelessWidget {
  SquareAvatar({
    this.avatarUrl,
  });

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        avatarUrl,
        height: 40.0,
        width: 40.0,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
              ApiHttpRepository.api +
                  "uploads/post/image/post-1639258474966-61b28a610a654cdd7b39171c.jpeg",
              height: 40.0,
              width: 40.0,
              fit: BoxFit.fill);
        },
        fit: BoxFit.fill,
      ),
    );
  }
}
