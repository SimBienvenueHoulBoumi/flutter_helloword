import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/ecran_accueil.dart';
import 'screens/ecran_a_propos.dart';
import 'constants/app_routes.dart';

// ==========================================
// APPLICATION : Configuration principale avec Riverpod
// ==========================================
// 
// Ce fichier configure l'application Flutter
// avec le thème et les paramètres globaux
//
// ✅ AMÉLIORATIONS :
// - Routes nommées pour une meilleure navigation
// - Gestion centralisée des routes
// - Riverpod pour la gestion d'état
//
// ==========================================

class MonApplicationFlutter extends StatelessWidget {
  const MonApplicationFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ ProviderScope = Nécessaire pour Riverpod
    // Enveloppe toute l'application pour activer Riverpod
    return ProviderScope(
      child: MaterialApp(
        title: 'Mon Premier App Flutter',
        debugShowCheckedModeBanner: false, // Cache la bannière "DEBUG"
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // ✅ Routes nommées pour une meilleure navigation
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => const EcranAccueil(),
          AppRoutes.aPropos: (context) => const EcranAPropos(),
        },
        // ✅ Fallback en cas d'erreur de route
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(title: const Text('Erreur')),
              body: Center(
                child: Text('Route inconnue: ${settings.name}'),
              ),
            ),
          );
        },
      ),
    );
  }
}