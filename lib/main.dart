import 'package:flutter/material.dart';
import 'app_route.dart';

void main() {
  runApp(BreakingBadApp(
     appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatefulWidget {
  const BreakingBadApp({Key? key, required this.appRouter}) : super(key: key);

  final AppRouter appRouter;

  @override
  State<BreakingBadApp> createState() => _BreakingBadAppState();
}

class _BreakingBadAppState extends State<BreakingBadApp> {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: widget.appRouter.generateRoute,
    );
  }
}
