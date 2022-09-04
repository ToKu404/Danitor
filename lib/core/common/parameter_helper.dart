import 'package:flutter/material.dart';

mixin DependencyStateMixin<T extends StatefulWidget> on State<T> {
  bool isInit = false;

  void onInit();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      onInit();
      isInit = true;
    }
  }
}

extension RouteContextExtension on BuildContext {
  Object? get parameter => ModalRoute.of(this)?.settings.arguments;
}

mixin ParameterStateMixin<T extends StatefulWidget, E> on State<T> {
  E get parameter => context.parameter as E;
}

typedef JsonObject = Map<String, dynamic>;
