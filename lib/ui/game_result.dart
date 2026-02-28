// type Result struct {
// 	Winner                 string `json:"winner"`                 // "Player 1", "Player 2", or "Tie"
// 	PlayerHandCombination1 Cards  `json:"playerHandCombination1"` // Player 1 Hand combination (e.g., "Straight", "Flush")
// 	PlayerHandCombination2 Cards  `json:"playerHandCombination2"` // Player 2 Hand combination (e.g., "Straight", "Flush")
// 	PlayerCombination1     string `json:"playerCombinationName1"` // Player 1 Hand Combination Name
// 	PlayerCombination2     string `json:"playerCombinationName2"` // Player 2 Hand Combination Name
// }

// type TexasHoldemResponse struct {
// 	CommunityCards Cards  `json:"communityCards"`
// 	Player1        Player `json:"player1"`
// 	Player2        Player `json:"player2"`
// 	Result         Result `json:"result"`
// }
import 'package:flutter/material.dart';
import "../models/texas_holdem.dart";
import "./deck_hand.dart";

class GameResult extends StatelessWidget {
  final TexasHoldemResult? result;

  const GameResult({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    if (result == null) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              "Result:",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              "Winner: ${result?.winner}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
        DeckHand(
          cards: result?.playerHandCombination1 ?? [],
          labelText: "Player 1 Combination: ${result?.playercombinationName1}",
        ),
        SizedBox(height: 16),
        DeckHand(
          cards: result?.playerHandCombination2 ?? [],
          labelText: "Player 2 Combination: ${result?.playercombinationName2}",
        ),
      ],
    );
  }
}
