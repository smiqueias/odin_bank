import 'package:flutter/material.dart';


// ============================================
// Base reutilizável (pode ir no core)
// ============================================
abstract base class ModuleEntryPoint<S> extends StatefulWidget {
  final S initialRoute;
  final VoidCallback? onFlowFinished;

  const ModuleEntryPoint({
    super.key,
    required this.initialRoute,
    this.onFlowFinished,
  });
}

abstract class ModuleEntryPointState<S, N extends ModuleEntryPoint<S>>
    extends State<N> {
  final navKey = GlobalKey<NavigatorState>();

  /// Cada módulo implementa só isso:
  Widget prepareRoutes(S route);

  /// Cada módulo implementa setup/dispose da DI:
  void onSetup();
  void onDispose();

  void navigateTo(S route) {
    navKey.currentState?.push(
      MaterialPageRoute(builder: (_) => prepareRoutes(route)),
    );
  }

  void pop() => navKey.currentState?.pop();

  void finishFlow() => widget.onFlowFinished?.call();

  @override
  void initState() {
    super.initState();
    onSetup();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => prepareRoutes(widget.initialRoute),
      ),
    );
  }
}