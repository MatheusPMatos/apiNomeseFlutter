import 'package:asyncstate/asyncstate.dart';
import 'package:flutter/material.dart';
import 'package:flutteribgeapi/src/core/loader/loader.dart';

import 'feature/home/home_page.dart';

class WebApp extends StatelessWidget {

  const WebApp({ super.key });

   @override
   Widget build(BuildContext context) {
       return AsyncStateBuilder(
        customLoader: const Loader(),
        builder: (asyncNavigatorObserver) {
          return MaterialApp(
            title: 'web 4 bimestre',
            navigatorObservers: [asyncNavigatorObserver],
            routes: {
          '/' :(_) => const HomePage(),
          
        },
       
          );
        },
       
       );
  }
}