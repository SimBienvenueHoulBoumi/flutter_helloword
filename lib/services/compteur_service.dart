// ==========================================
// SERVICE : Service pour les opérations de compteur
// ==========================================
// 
// Ce service abstrait les opérations de données du compteur.
// Sépare la logique métier (controller) de la gestion des données.
// 
// ✅ AVANTAGES :
// - Séparation claire des responsabilités
// - Facilite les tests (mockable)
// - Facilite l'ajout d'une source de données (API, BDD, etc.)
// - Réutilisable dans différents controllers
//
// ==========================================

import '../models/compteur_model.dart';
import '../constants/app_values.dart';

/// Service pour gérer les opérations de données du compteur
class CompteurService {
  /// Valide une valeur de compteur
  /// Retourne true si la valeur est valide, false sinon
  bool validerValeur(int valeur) {
    return valeur >= AppValues.compteurMin && 
           valeur <= AppValues.compteurMax;
  }

  /// Calcule la nouvelle valeur après incrémentation
  /// Retourne la nouvelle valeur ou null si la limite est atteinte
  int? calculerIncrementation(int valeurActuelle) {
    if (valeurActuelle >= AppValues.compteurMax) {
      return null; // Limite atteinte
    }
    return valeurActuelle + 1;
  }

  /// Calcule la nouvelle valeur après décrémentation
  /// Retourne la nouvelle valeur ou null si la limite est atteinte
  int? calculerDecrementation(int valeurActuelle) {
    if (valeurActuelle <= AppValues.compteurMin) {
      return null; // Limite atteinte
    }
    return valeurActuelle - 1;
  }

  /// Calcule la nouvelle valeur après multiplication par 2
  /// Retourne la nouvelle valeur ou null si la limite serait dépassée
  int? calculerMultiplication(int valeurActuelle) {
    final nouvelleValeur = valeurActuelle * 2;
    if (nouvelleValeur > AppValues.compteurMax) {
      return null; // Limite serait dépassée
    }
    return nouvelleValeur;
  }

  /// Crée un nouveau modèle de compteur avec une valeur validée
  /// Lance une exception si la valeur est invalide
  CompteurModel creerCompteur({int valeur = 0}) {
    if (!validerValeur(valeur)) {
      throw CompteurModelException(
        'La valeur $valeur n\'est pas dans les limites acceptables',
      );
    }
    return CompteurModel(valeur: valeur);
  }

  /// Met à jour un modèle existant avec une nouvelle valeur
  /// Retourne un nouveau modèle ou null si la valeur est invalide
  CompteurModel? mettreAJourValeur(CompteurModel model, int nouvelleValeur) {
    if (!validerValeur(nouvelleValeur)) {
      return null; // Valeur invalide
    }
    return model.copyWith(
      valeur: nouvelleValeur,
      dateModification: DateTime.now(),
    );
  }

  /// Sauvegarde un modèle en JSON
  /// Pourrait être étendu pour sauvegarder dans une base de données
  Map<String, dynamic> sauvegarder(CompteurModel model) {
    return model.toJson();
  }

  /// Charge un modèle depuis JSON
  /// Pourrait être étendu pour charger depuis une base de données
  CompteurModel charger(Map<String, dynamic> json) {
    return CompteurModel.fromJson(json);
  }
}

