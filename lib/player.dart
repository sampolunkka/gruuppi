class Player {
  String name;
  List<Want> wants = [];

  Player(this.name);
}

class Want {
  Format? format;
  Level? level;
}

class Format {
  String? game;
  String? format;
}

enum Level {
  casual,
  competitive,
  any,
}

extension LevelExtension on Level {
  String get name {
    switch (this) {
      case Level.casual:
        return 'Casual';
      case Level.competitive:
        return 'Competitive';
      case Level.any:
        return 'Any';
    }
  }
}