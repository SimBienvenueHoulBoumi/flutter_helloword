import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/compteur_model.dart';
import '../constants/app_values.dart';
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
// ==========================================

// Notifier = Classe Riverpod 3.x pour gérer l'état
// Plus moderne et simple que StateNotifier
class CompteurController extends Notifier<CompteurModel> {
  // build() = Méthode requise qui retourne l'état initial
  @override
  CompteurModel build() {
    return CompteurModel();
  }

  // ✅ Méthode pour augmenter le compteur avec validation
  void incrementer() {
    // Validation : vérifier si on peut encore incrémenter
    if (state.valeur >= AppValues.compteurMax) {
      // Ne pas dépasser la limite maximale
      return;
    }

    try {
      state = state.copyWith(
        valeur: state.valeur + 1,
        dateModification: DateTime.now(),
      );
    } catch (e) {
      // Gestion d'erreur si la validation échoue
      // (ne devrait pas arriver grâce à la vérification précédente)
      throw StateError('Impossible d\'incrémenter: $e');
    }
  }

  // ✅ Méthode pour diminuer le compteur avec validation
  void decrementer() {
    // Validation : vérifier si on peut encore décrémenter
    if (state.valeur <= AppValues.compteurMin) {
      // Ne pas descendre en dessous de la limite minimale
      return;
    }

    try {
      state = state.copyWith(
        valeur: state.valeur - 1,
        dateModification: DateTime.now(),
      );
    } catch (e) {
      // Gestion d'erreur si la validation échoue
      throw StateError('Impossible de décrémenter: $e');
    }
  }

  // Méthode pour remettre à zéro
  void reinitialiser() {
    // Crée un nouveau modèle avec valeur 0
    state = CompteurModel();
  }

  // ✅ Méthode pour multiplier par 2 avec validation
  void multiplierPar2() {
    final nouvelleValeur = state.valeur * 2;
    
    // Validation : vérifier si le résultat est dans les limites
    if (nouvelleValeur > AppValues.compteurMax) {
      // Ne pas dépasser la limite maximale
      return;
    }

    try {
      state = state.copyWith(
        valeur: nouvelleValeur,
        dateModification: DateTime.now(),
      );
    } catch (e) {
      throw StateError('Impossible de multiplier: $e');
    }
  }

  // Méthode pour sauvegarder en JSON
  Map<String, dynamic> sauvegarder() {
    return state.toJson();
  }

  // ✅ Méthode pour charger depuis JSON avec gestion d'erreurs
  void charger(Map<String, dynamic> json) {
    try {
      state = CompteurModel.fromJson(json);
    } catch (e) {
      // Si le chargement échoue, réinitialiser à zéro
      state = CompteurModel();
      // Relancer l'erreur pour que l'appelant soit informé
      rethrow;
    }
  }
}

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