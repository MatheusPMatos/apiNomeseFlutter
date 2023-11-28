import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutteribgeapi/src/web_app.dart';

void main() {
  runApp(const ProviderScope(child: WebApp(),));
}

