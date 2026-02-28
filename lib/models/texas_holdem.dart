class TexasHoldemResponse {
  final List<String> communityCards;
  final Player player1;
  final Player player2;
  final TexasHoldemResult result;

  TexasHoldemResponse({
    required this.communityCards,
    required this.player1,
    required this.player2,
    required this.result,
  });
}

class Player {
  final List<String> hand;
  final List<String> combination;
  final PlayerCombinations combinations;

  Player({
    required this.hand,
    required this.combination,
    required this.combinations,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      hand: List<String>.from(json['hand'] ?? []),
      combination: List<String>.from(json['combination'] ?? []),
      combinations: PlayerCombinations.fromJson(json['combinations'] ?? {}),
    );
  }
}

class PlayerCombinations {
  final List<String> highCard;

  final List<String> pair;
  final List<String> twoPair;
  final List<String> threeOfAKind;
  final List<String> straight;
  final List<String> flush;

  final List<String> fullHouse;

  final List<String> fourOfAKind;
  final List<String> straightFlush;
  final List<String> royalFlush;

  PlayerCombinations({
    required this.highCard,
    required this.pair,
    required this.twoPair,
    required this.threeOfAKind,
    required this.straight,
    required this.flush,
    required this.fullHouse,
    required this.fourOfAKind,
    required this.straightFlush,
    required this.royalFlush,
  });

  factory PlayerCombinations.fromJson(Map<String, dynamic> json) {
    return PlayerCombinations(
      highCard: List<String>.from(json['highCard'] ?? []),
      pair: List<String>.from(json['pair'] ?? []),
      twoPair: List<String>.from(json['twoPair'] ?? []),
      threeOfAKind: List<String>.from(json['threeOfAKind'] ?? []),
      straight: List<String>.from(json['straight'] ?? []),
      flush: List<String>.from(json['flush'] ?? []),
      fullHouse: List<String>.from(json['fullHouse'] ?? []),
      fourOfAKind: List<String>.from(json['fourOfAKind'] ?? []),
      straightFlush: List<String>.from(json['straightFlush'] ?? []),
      royalFlush: List<String>.from(json['royalFlush'] ?? []),
    );
  }
}

class TexasHoldemResult {
  final String winner;
  final List<String> playerHandCombination1;
  final List<String> playerHandCombination2;
  final String playercombinationName1;
  final String playercombinationName2;

  TexasHoldemResult({
    required this.winner,
    required this.playerHandCombination1,
    required this.playerHandCombination2,
    required this.playercombinationName1,
    required this.playercombinationName2,
  });

  factory TexasHoldemResult.fromJson(Map<String, dynamic> json) {
    return TexasHoldemResult(
      winner: json['winner'] ?? '',
      playerHandCombination1: List<String>.from(
        json['playerHandCombination1'] ?? [],
      ),
      playerHandCombination2: List<String>.from(
        json['playerHandCombination2'] ?? [],
      ),
      playercombinationName1: json['playerCombinationName1'] ?? '',
      playercombinationName2: json['playerCombinationName2'] ?? '',
    );
  }
}
