import 'package:Eletor/utils/string_values.dart';
import 'package:Eletor/widgets/severitylevels/severityLevelsInterface.dart';
import 'package:Eletor/widgets/severitylevels/severity_symbol.dart';
import 'package:Eletor/widgets/severitylevels/severity_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Levels { HIGH, Middle, LOW }

class SeverityLevels implements SeverityInterfaces {
  String text;
  final Levels levels;

  Color color;

  SeverityLevels({@required this.levels}) {
    init();
  }

  @override
  Widget severitySymbol() {
    return SeveritySymbol(color: color).circleSymbol();
  }

  @override
  Widget severityText() {
    return SeverityText(color: color, text: text).severityText();
  }

  init() {
    color = _severityColor();
    text = _textLevel();
  }

  Color _severityColor() {
    if (levels == Levels.HIGH) return Colors.red;
    if(levels == Levels.Middle) return Colors.orange;
    return Colors.yellow[600];
  }

  String _textLevel() {
    if (levels == Levels.HIGH) return StringValue.highLevel;
    if(levels == Levels.Middle) return StringValue.middleLevel;
    return StringValue.lowLevel;
  }

  Widget severityWidget() {
    return Row(
      children: [
        severitySymbol(),
        SizedBox(
          height: 3,
          width: 3,
        ),
        severityText()
      ],
    );
  }
}
