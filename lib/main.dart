import 'package:dam_u4_proyecto2_18401084/pages/home.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: PaginaPrincipal(),
      theme: const CupertinoThemeData(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
        return CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
          ),
          child: child!,
        );
      },
    );
  }
}