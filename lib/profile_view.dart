import 'package:flutter/material.dart';
import 'package:gruuppi/player.dart';

class ProfileView extends StatefulWidget {
  Player player;

  ProfileView(this.player, {super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text(
              widget.player.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          width: 180,
          height: 180,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        ListView(
          shrinkWrap: true,
          children: widget.player.wants.map((want) {
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: FormatRow(want),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class FormatRow extends StatelessWidget {
  final Want want;

  const FormatRow(this.want, {super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = 8;
    return Row(
      children: [
        WantTag(want.format?.game ?? 'game' , TagType.game),
        SizedBox(width: spacing),
        WantTag(want.format?.format ?? 'format', TagType.format),
        SizedBox(width: spacing),
        WantTag(want.level?.name ?? 'default', TagType.level),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

enum TagType { game, format, level }

class WantTag extends StatelessWidget {
  final String text;
  final TagType type;

  // Padding
  final double left = 8;
  final double top = 4;
  final double right = 8;
  final double bottom = 4;

  const WantTag(this.text, this.type, {super.key});

  Color getColor() {
    switch (type) {
      case TagType.game:
        return Colors.redAccent;
      case TagType.format:
        return Colors.greenAccent;
      case TagType.level:
        return Colors.orangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text),
    );
  }
}
