import 'package:flutter/material.dart';

class KlavyeninKapanmasi extends StatelessWidget {

  final widget;

  KlavyeninKapanmasi({Key key, this.widget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // Ekrana tıkladığında klavyenin kapanmasını sağlar focusScope ile.
      onTap: () {
        FocusScope.of(context).requestFocus(
            new FocusNode()); // Ekrana tıkladığında klavyenin kapanmasını sağlar behavior ile.
      },
      child: widget,
    );
  }
}
