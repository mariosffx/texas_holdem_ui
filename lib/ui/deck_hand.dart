import 'package:flutter/material.dart';
import './deck_card.dart';

class DeckHand extends StatelessWidget {
  final String labelText;
  final List<String> cards;
  final String? status;

  const DeckHand({
    super.key,
    required this.labelText,
    required this.cards,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Wrap(
          runSpacing: 16,
          spacing: 16,
          children: cards
              .map(
                (card) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: DeckCard(cardName: card),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
