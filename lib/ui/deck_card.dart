import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeckCard extends StatelessWidget {
  final String cardName;

  const DeckCard({super.key, required this.cardName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/deck/$cardName.svg',
      width: 80,
      height: 160,
      fit: BoxFit.contain,
    );
  }
}
