import "package:webview_flutter/webview_flutter.dart";
import "package:flutter/material.dart";

enum _MenuOptions {
  navigationDelegate,
}

class Menu extends StatelessWidget {
  final WebViewController controller;

  const Menu({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case _MenuOptions.navigationDelegate:
            await controller.loadRequest(Uri.parse("https://youtube.com"));
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text("Navigate to YouTube"),
        ),
      ],
    );
    throw UnimplementedError();
  }
}
