import "package:webview_flutter/webview_flutter.dart";
import "package:flutter/material.dart";

enum _MenuOptions {
  navigationDelegate,
  userAgent,
}

class Menu extends StatefulWidget {
  final WebViewController controller;

  const Menu({
    required this.controller,
    super.key,
  });

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) async {
        switch (value) {
          case _MenuOptions.navigationDelegate:
            await widget.controller
                .loadRequest(Uri.parse("https://youtube.com"));
            break;
          case _MenuOptions.userAgent:
            final userAgent = await widget.controller
                .runJavaScriptReturningResult("navigator.userAgent");
            if (!mounted) {
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("$userAgent"),
            ));
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.navigationDelegate,
          child: Text("Navigate to YouTube"),
        ),
        const PopupMenuItem(
          value: _MenuOptions.userAgent,
          child: Text("Show user-agent"),
        ),
      ],
    );
    throw UnimplementedError();
  }
}
