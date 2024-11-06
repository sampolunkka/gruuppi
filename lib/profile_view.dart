import 'package:flutter/material.dart';
import 'package:gruuppi/player.dart';
import 'package:gruuppi/utils.dart';

class ProfileView extends StatefulWidget {
  Player player;

  ProfileView(this.player, {super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [HexColor('#286169'), HexColor('#332d41')],
        ),
      ),
      child: Stack(
        children: [
          AvatarContainer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 100),
                BioContainer(widget.player.name, widget.player.bio),
                ListView(
                  shrinkWrap: true,
                  children: widget.player.games!
                      .map((game) => GameWishContainer(game, game.formats!))
                      .toList(),
                ),
              ],
            ),
          ),
          DecisionContainer(),
        ],
      ),
    );
  }
}

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.sizeOf(context).width,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          'assets/placeholder/squirrels.png',
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

class NameContainer extends StatelessWidget {
  final String name;

  const NameContainer(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          fontFamily: 'Domine',
          color: HexColor('#FFFFFF'),
        ),
      ),
    );
  }
}

class BioContainer extends StatelessWidget {
  final String name;
  final String bio;

  const BioContainer(this.name, this.bio, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HexColor('333942').withOpacity(1),
            HexColor('#000000').withOpacity(0.3)
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: HexColor('#FFFFFF').withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameContainer(name),
          Divider(color: HexColor('#FFFFFF').withOpacity(0.4), thickness: 1),
          Text(
            bio,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              fontFamily: 'Lato',
              color: HexColor('#FFFFFF'),
            ),
          ),
        ],
      ),
    );
  }
}

class GameWishContainer extends StatelessWidget {
  final Game game;
  final List<Format> formats;

  const GameWishContainer(this.game, this.formats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor('#FFFFFF').withOpacity(0.2),
              HexColor('#FFFFFF').withOpacity(0.1)
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: HexColor('#FFFFFF').withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(game.name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Domine',
                        color: HexColor('#FFFFFF')))),
            Divider(color: HexColor('#FFFFFF').withOpacity(0.4), thickness: 1),
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                for (int i = 0; i < formats.length; i++)
                  FormatRow(formats[i], i),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FormatRow extends StatelessWidget {
  final Format format;
  final int index;

  const FormatRow(this.format, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 8;
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 0 : spacing),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor('#000000').withOpacity(0.3),
          borderRadius: BorderRadius.circular(26),
        ),
        padding: EdgeInsets.all(spacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TagContainer(format.name, TagType.format),
            SizedBox(width: spacing),
            TagContainer(format.level.name, TagType.level),
            SizedBox(width: spacing),
            TagContainer('Proxies OK', TagType.proxy),
          ],
        ),
      ),
    );
  }
}

enum TagType { game, format, level, proxy }

class TagContainer extends StatelessWidget {
  final String text;
  final TagType type;

  // Padding
  final double left = 8;
  final double top = 4;
  final double right = 8;
  final double bottom = 4;

  const TagContainer(this.text, this.type, {super.key});

  Color getTextColor() {
    switch (type) {
      case TagType.game:
        return HexColor('#FFCDD2');
      case TagType.format:
        return HexColor('#C8E6C9');
      case TagType.level:
        return HexColor('#FFE0B2');
      case TagType.proxy:
        return HexColor('#7de8ff');
    }
  }

  Color getBorderColor() {
    switch (type) {
      case TagType.game:
        return HexColor('#E57373');
      case TagType.format:
        return HexColor('#81C784');
      case TagType.level:
        return HexColor('#FFB74D');
      case TagType.proxy:
        return HexColor('#52a0b1');
    }
  }

  /*
  Color getTextColor() {
    switch (type) {
      case TagType.game:
        return HexColor('#D32F2F');
      case TagType.format:
        return HexColor('#388E3C');
      case TagType.level:
        return HexColor('#F57C00');
      case TagType.proxy:
        return HexColor('#FFFFFF');
    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      decoration: BoxDecoration(
        border: Border.all(
          color: getTextColor().withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(color: getTextColor(), fontSize: 14),
      ),
    );
  }
}

class DecisionContainer extends StatelessWidget {
  const DecisionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

