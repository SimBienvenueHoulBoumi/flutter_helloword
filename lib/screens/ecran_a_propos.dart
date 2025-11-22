import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_spacing.dart';
import '../constants/app_values.dart';

// ==========================================
// ÉCRAN : À propos
// ==========================================
// 
// Cet écran affiche des informations sur l'application
// avec un bouton de retour vers la page d'accueil
// 
// ✅ AMÉLIORATIONS :
// - Utilise les constantes au lieu de magic numbers
// - Accessibilité améliorée
//
// ==========================================

class EcranAPropos extends ConsumerWidget {
  const EcranAPropos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Semantics(
          label: 'À propos',
          child: const Text('À propos'),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium), // ✅ Utilise la constante
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.medium), // ✅ Utilise la constante

              // Titre
              Center(
                child: Semantics(
                  label: AppValues.appTitle,
                  header: true,
                  child: Text(
                    AppValues.appTitle, // ✅ Utilise la constante
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xxl), // ✅ Utilise la constante

              // Section Description
              _SectionAPropos(
                titre: 'Description',
                contenu:
                    'Cette application est un projet pédagogique pour apprendre Flutter étape par étape. '
                    'Elle présente un compteur simple avec une architecture professionnelle utilisant Riverpod.',
              ),

              const SizedBox(height: AppSpacing.medium), // ✅ Utilise la constante

              // Section Technologies
              _SectionAPropos(
                titre: 'Technologies utilisées',
                contenu: '• Flutter Framework\n'
                    '• Riverpod (Gestion d\'état)\n'
                    '• Dart Language\n'
                    '• Material Design 3',
              ),

              const SizedBox(height: AppSpacing.medium), // ✅ Utilise la constante

              // Section Architecture
              _SectionAPropos(
                titre: 'Architecture',
                contenu: 'L\'application suit les bonnes pratiques Flutter :\n\n'
                    '• Models : Structure des données\n'
                    '• Controllers : Logique métier\n'
                    '• Screens : Interfaces utilisateur\n'
                    '• Widgets : Composants réutilisables',
              ),

              const SizedBox(height: AppSpacing.medium), // ✅ Utilise la constante

              // Section Version
              _SectionAPropos(
                titre: 'Version',
                contenu: '${AppValues.appVersion}\n\n' // ✅ Utilise la constante
                    'Première version de l\'application avec un compteur simple.',
              ),

              const SizedBox(height: AppSpacing.medium), // ✅ Utilise la constante
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// WIDGET RÉUTILISABLE : Section À propos
// ==========================================

class _SectionAPropos extends StatelessWidget {
  final String titre;
  final String contenu;

  const _SectionAPropos({
    required this.titre,
    required this.contenu,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$titre: $contenu',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.medium), // ✅ Utilise la constante
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: AppSpacing.small), // ✅ Utilise la constante
            Text(
              contenu,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}