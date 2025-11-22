import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compteur_model.dart';
import '../services/compteur_service.dart';
import '../utils/compteur_utils.dart';

// ==========================================
// CONTROLLER : Gestion de la logique du compteur avec Riverpod
// ==========================================
// 
// ✅ POURQUOI RIVERPOD ?
// 1. ✅ Plus sûr : compile-time safety (erreurs détectées avant l'exécution)
// 2. ✅ Plus performant : meilleure optimisation du rebuild
// 3. ✅ Plus facile à tester : providers testables facilement
// 4. ✅ Plus moderne : successeur de Provider, recommandé par Google
// 5. ✅ Meilleure gestion de dépendances : dépendances automatiques
// 6. ✅ Hot reload amélioré : recharge plus rapide
//
// ✅ AMÉLIORATIONS :
// - Utilise le service pour abstraire les opérations de données
// - Sépare la logique métier de la gestion des données
// - Facilite les tests (service mockable)
//
// ==========================================

// Notifier = Classe Riverpod 3.x pour gérer l'état
// Plus moderne et simple que StateNotifier
class CompteurController extends Notifier<CompteurModel> {
  // ✅ Service injecté via le provider
  late final CompteurService _service;

  // build() = Méthode requise qui retourne l'état initial
  @override
  CompteurModel build() {
    // ✅ Injection du service via le provider
    _service = ref.read(compteurServiceProvider);
    return _service.creerCompteur();
  }

  // ✅ Méthode pour augmenter le compteur avec validation via service
  void incrementer() {
    // ✅ Utilise le service pour calculer la nouvelle valeur
    final nouvelleValeur = _service.calculerIncrementation(state.valeur);
    if (nouvelleValeur == null) {
      // Limite atteinte, ne rien faire
      return;
    }

    // ✅ Utilise le service pour mettre à jour le modèle
    final nouveauModele = _service.mettreAJourValeur(state, nouvelleValeur);
    if (nouveauModele != null) {
      state = nouveauModele;
    }
  }

  // ✅ Méthode pour diminuer le compteur avec validation via service
  void decrementer() {
    // ✅ Utilise le service pour calculer la nouvelle valeur
    final nouvelleValeur = _service.calculerDecrementation(state.valeur);
    if (nouvelleValeur == null) {
      // Limite atteinte, ne rien faire
      return;
    }

    // ✅ Utilise le service pour mettre à jour le modèle
    final nouveauModele = _service.mettreAJourValeur(state, nouvelleValeur);
    if (nouveauModele != null) {
      state = nouveauModele;
    }
  }

  // Méthode pour remettre à zéro via service
  void reinitialiser() {
    // ✅ Utilise le service pour créer un nouveau modèle
    state = _service.creerCompteur();
  }

  // ✅ Méthode pour multiplier par 2 avec validation via service
  void multiplierPar2() {
    // ✅ Utilise le service pour calculer la nouvelle valeur
    final nouvelleValeur = _service.calculerMultiplication(state.valeur);
    if (nouvelleValeur == null) {
      // Limite serait dépassée, ne rien faire
      return;
    }

    // ✅ Utilise le service pour mettre à jour le modèle
    final nouveauModele = _service.mettreAJourValeur(state, nouvelleValeur);
    if (nouveauModele != null) {
      state = nouveauModele;
    }
  }

  // Méthode pour sauvegarder en JSON via service
  Map<String, dynamic> sauvegarder() {
    return _service.sauvegarder(state);
  }

  // ✅ Méthode pour charger depuis JSON avec gestion d'erreurs via service
  void charger(Map<String, dynamic> json) {
    try {
      state = _service.charger(json);
    } catch (e) {
      // Si le chargement échoue, réinitialiser à zéro
      state = _service.creerCompteur();
      // Relancer l'erreur pour que l'appelant soit informé
      rethrow;
    }
  }
}

// ==========================================
// PROVIDER : Crée et expose le service
// ==========================================

/// Provider pour le service de compteur
/// Permet d'injecter le service dans le controller
final compteurServiceProvider = Provider<CompteurService>((ref) {
  return CompteurService();
});

// ==========================================
// PROVIDER : Crée et expose le controller
// ==========================================
// 
// Provider = Point d'accès unique au controller
// ✅ Avantages :
// - Pas besoin de créer le controller manuellement
// - Riverpod gère le cycle de vie automatiquement
// - Accessible partout dans l'app via ProviderScope
// - Hot reload amélioré
//
// ==========================================

// NotifierProvider = Provider pour un Notifier (Riverpod 3.x)
// Permet de créer et d'accéder au CompteurController
final compteurControllerProvider =
    NotifierProvider<CompteurController, CompteurModel>(
  CompteurController.new,
);

// Provider pour obtenir juste la valeur (int)
// ✅ Performance : se rebuild seulement si la valeur change
final compteurValueProvider = Provider<int>((ref) {
  return ref.watch(compteurControllerProvider).valeur;
});

// ✅ Provider pour obtenir le message (utilise l'utilitaire, pas de duplication)
final compteurMessageProvider = Provider<String>((ref) {
  final compteur = ref.watch(compteurControllerProvider);
  // Utilise l'utilitaire pour éviter la duplication
  return CompteurUtils.getMessage(compteur.valeur);
});
