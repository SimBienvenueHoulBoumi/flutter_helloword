import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/compteur_display.dart';
import '../widgets/boutons_controle.dart';
import '../widgets/message_aide.dart';
import '../controllers/compteur_controller.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_routes.dart';
import '../utils/date_formatter.dart';

// ==========================================
// ÉCRAN : Page d'accueil avec Riverpod
// ==========================================
// 
// Cet écran affiche l'interface (UI) et utilise
// Riverpod pour accéder au controller.
// 
// ✅ AMÉLIORATIONS :
// - Utilise les constantes au lieu de magic numbers
// - Utilise DateFormatter pour éviter la duplication
// - Routes nommées pour la navigation
// - Accessibilité améliorée
//
// ==========================================

class EcranAccueil extends ConsumerWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compteurController = ref.read(compteurControllerProvider.notifier);
    final compteurModel = ref.watch(compteurControllerProvider);
    final compteurValue = ref.watch(compteurValueProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Semantics(
          label: 'Mon Premier App Flutter',
          child: const Text('Mon Premier App Flutter'),
        ),
        centerTitle: true,
        // ✅ Bouton pour naviguer vers l'écran "À propos" avec route nommée
        actions: [
          Semantics(
            label: 'Ouvrir la page À propos',
            button: true,
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              tooltip: 'À propos',
              onPressed: () {
                // ✅ Utilise une route nommée pour la navigation
                Navigator.of(context).pushNamed(AppRoutes.aPropos);
              },
            ),
          ),
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Affichage du titre
            Semantics(
              label: 'Vous avez cliqué sur le bouton',
              child: Text(
                'Vous avez cliqué sur le bouton :',
                style: AppTextStyles.titleMedium, // ✅ Utilise la constante
              ),
            ),

            const SizedBox(height: AppSpacing.xl), // ✅ Utilise la constante

            // ✅ Utilise la valeur du provider (automatiquement mise à jour)
            CompteurDisplay(compteur: compteurValue),

            const SizedBox(height: AppSpacing.large), // ✅ Utilise la constante

            // ✅ Utilise les méthodes du controller
            BoutonsControle(
              onIncrementer: compteurController.incrementer,
              onDecrementer: compteurController.decrementer,
              onReinitialiser: compteurController.reinitialiser,
              compteur: compteurValue,
            ),

            const SizedBox(height: AppSpacing.xl), // ✅ Utilise la constante

            // ✅ Utilise le message du provider (automatiquement mis à jour)
            MessageAide(compteur: compteurValue),

            // ✅ BONUS : Affichage des dates avec DateFormatter
            const SizedBox(height: AppSpacing.xl), // ✅ Utilise la constante
            Semantics(
              label: 'Date de création du compteur',
              child: Text(
                'Créé le : ${DateFormatter.formatDateAffichage(compteurModel.dateCreation)}', // ✅ Utilise DateFormatter
                style: AppTextStyles.bodySmall, // ✅ Utilise la constante
              ),
            ),
            if (compteurModel.dateModification != null)
              Semantics(
                label: 'Date de dernière modification du compteur',
                child: Text(
                  'Modifié le : ${DateFormatter.formatDateAffichage(compteurModel.dateModification!)}', // ✅ Utilise DateFormatter
                  style: AppTextStyles.bodySmall, // ✅ Utilise la constante
                ),
              ),

            const SizedBox(height: AppSpacing.large), // ✅ Utilise la constante

            // ✅ Bouton pour aller à l'écran "À propos" avec route nommée
            Semantics(
              label: 'Aller à la page À propos',
              button: true,
              child: ElevatedButton.icon(
                onPressed: () {
                  // ✅ Utilise une route nommée pour la navigation
                  Navigator.of(context).pushNamed(AppRoutes.aPropos);
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('À propos'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl, // ✅ Utilise la constante
                    vertical: AppSpacing.medium, // ✅ Utilise la constante
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Semantics(
        label: 'Incrémenter le compteur',
        button: true,
        child: FloatingActionButton.extended(
          onPressed: compteurController.incrementer,
          tooltip: 'Incrémenter',
          icon: const Icon(Icons.plus_one),
          label: const Text('Ajouter 1'),
        ),
      ),
    );
  }
}