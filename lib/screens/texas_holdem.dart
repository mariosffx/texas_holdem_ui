import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../ui/deck_hand.dart';
import '../ui/custom_button.dart';
import '../ui/message.dart';
import '../ui/game_result.dart';
import "../models/texas_holdem.dart";

class TexasHoldemScreen extends StatefulWidget {
  const TexasHoldemScreen({super.key});

  @override
  State<TexasHoldemScreen> createState() => _TexasHoldemScreenState();
}

class _TexasHoldemScreenState extends State<TexasHoldemScreen> {
  final String _baseUrl =
      dotenv.env['API_BASE_URL'] ?? "https://texas-holdem-api.web-coders.xyz";

  String? _messageType;
  String? _messageText;
  bool _loading = false;

  Player? _player1;
  Player? _player2;
  List<String>? _communityCards;
  TexasHoldemResult? _result;

  Future<void> _play() async {
    setState(() {
      _loading = true;
      _messageType = null;
      _messageText = null;
    });

    try {
      final uri = Uri.parse("$_baseUrl/api/play/texas-holdem");
      final res = await http.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );

      final data = jsonDecode(res.body);

      setState(() {
        _messageType = "success";
        _messageText = "Game played successfully!";
        _player1 = Player.fromJson(data["player1"]);
        _player2 = Player.fromJson(data["player2"]);
        _communityCards = List<String>.from(data["communityCards"]);
        _result = TexasHoldemResult.fromJson(data["result"]);
      });
    } catch (e) {
      setState(() {
        _messageType = "error";
        _messageText = "$e";
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Texas Holdem")),
      body: Scrollbar(
        interactive: true,
        thumbVisibility: true,
        child: SingleChildScrollView(
          primary: true,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                CustomButton(
                  onPressed: _play,
                  text: "Play Game",
                  loading: _loading,
                ),
                SizedBox(height: 32),
                Message(messageText: _messageText, messageType: _messageType),
                SizedBox(height: 32),
                DeckHand(
                  cards: _communityCards ?? [],
                  labelText: "Community Cards",
                ),
                SizedBox(height: 32),
                DeckHand(cards: _player1?.hand ?? [], labelText: "Player 1"),
                SizedBox(height: 32),
                DeckHand(cards: _player2?.hand ?? [], labelText: "Player 2"),
                SizedBox(height: 32),
                GameResult(result: _result),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
