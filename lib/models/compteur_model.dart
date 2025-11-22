// ==========================================
// MODÈLE : Représentation des données du compteur
// ==========================================
// 
// Un modèle (Model) représente les DONNÉES de l'application.
// Il définit la structure des données, pas la logique.
// 
// ✅ AMÉLIORATIONS :
// - Validation des données
// - Gestion d'erreurs (try/catch)
// - Limites sur les valeurs
// - Messages d'erreur clairs
//
// ==========================================

import '../constants/app_values.dart';

/// Exception personnalisée pour les erreurs de validation
class CompteurModelException implements Exception {
  final String message;
  CompteurModelException(this.message);

  @override
  String toString() => 'CompteurModelException: $message';
}

class CompteurModel {
  // Variables privées : on ne peut pas les modifier directement
  final int _valeur;
  final DateTime _dateCreation;
  final DateTime? _dateModification;

  // Constructeur avec validation
  CompteurModel({
    int valeur = 0,
    DateTime? dateCreation,
    DateTime? dateModification,
  })  : _valeur = _validateValeur(valeur),
        _dateCreation = dateCreation ?? DateTime.now(),
        _dateModification = dateModification;

  // ✅ VALIDATION : Vérifie que la valeur est dans les limites acceptables
  static int _validateValeur(int valeur) {
    if (valeur < AppValues.compteurMin) {
      throw CompteurModelException(
        'La valeur $valeur est inférieure à la limite minimale (${AppValues.compteurMin})',
      );
    }
    if (valeur > AppValues.compteurMax) {
      throw CompteurModelException(
        'La valeur $valeur dépasse la limite maximale (${AppValues.compteurMax})',
      );
    }
    return valeur;
  }

  // Getters publics : permettent de lire les valeurs
  int get valeur => _valeur;
  DateTime get dateCreation => _dateCreation;
  DateTime? get dateModification => _dateModification;

  // Méthode pour créer une copie avec une nouvelle valeur
  // (Les modèles sont souvent immuables en Flutter)
  CompteurModel copyWith({
    int? valeur,
    DateTime? dateModification,
  }) {
    return CompteurModel(
      valeur: valeur ?? _valeur,
      dateCreation: _dateCreation,
      dateModification: dateModification ?? _dateModification ?? DateTime.now(),
    );
  }

  // Méthode pour convertir en JSON (utile pour sauvegarder)
  Map<String, dynamic> toJson() {
    return {
      'valeur': _valeur,
      'dateCreation': _dateCreation.toIso8601String(),
      'dateModification': _dateModification?.toIso8601String(),
    };
  }

  // ✅ GESTION D'ERREURS : Méthode pour créer depuis JSON avec validation
  factory CompteurModel.fromJson(Map<String, dynamic> json) {
    try {
      // Si JSON vide, créer un modèle par défaut
      if (json.isEmpty) {
        return CompteurModel(valeur: AppValues.compteurValeurInitiale);
      }

      // Extraction et validation de la valeur
      final valeurJson = json['valeur'];
      if (valeurJson == null) {
        // Si valeur manquante, utiliser la valeur par défaut
        return CompteurModel(
          valeur: AppValues.compteurValeurInitiale,
        );
      }

      // Vérifier que c'est bien un int
      if (valeurJson is! int) {
        throw CompteurModelException(
          'La valeur doit être un entier, reçu: ${valeurJson.runtimeType}',
        );
      }

      final valeur = valeurJson; // Pas besoin de cast, déjà vérifié avec is!

      // Validation de la valeur
      if (valeur < AppValues.compteurMin || valeur > AppValues.compteurMax) {
        throw CompteurModelException(
          'La valeur $valeur est hors limites (${AppValues.compteurMin} à ${AppValues.compteurMax})',
        );
      }

      // Extraction et validation de la date de création
      DateTime? dateCreation;
      if (json['dateCreation'] != null) {
        try {
          dateCreation = DateTime.parse(json['dateCreation'] as String);
        } catch (e) {
          throw CompteurModelException(
            'Format de date de création invalide: ${json['dateCreation']}',
          );
        }
      }

      // Extraction et validation de la date de modification
      DateTime? dateModification;
      if (json['dateModification'] != null) {
        try {
          dateModification = DateTime.parse(json['dateModification'] as String);
        } catch (e) {
          throw CompteurModelException(
            'Format de date de modification invalide: ${json['dateModification']}',
          );
        }
      }

      return CompteurModel(
        valeur: valeur,
        dateCreation: dateCreation,
        dateModification: dateModification,
      );
    } catch (e) {
      // Si c'est déjà une CompteurModelException, la relancer
      if (e is CompteurModelException) {
        rethrow;
      }
      // Sinon, envelopper dans une CompteurModelException
      throw CompteurModelException(
        'Erreur lors du parsing JSON: $e',
      );
    }
  }

  // Méthode pour obtenir une représentation textuelle
  @override
  String toString() {
    return 'CompteurModel(valeur: $_valeur, créé le: $_dateCreation)';
  }

  // Méthode pour comparer deux modèles
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CompteurModel &&
        other._valeur == _valeur &&
        other._dateCreation == _dateCreation;
  }

  @override
  int get hashCode => _valeur.hashCode ^ _dateCreation.hashCode;

  // ✅ MÉTHODE UTILITAIRE : Vérifier si la valeur est valide
  bool isValid() {
    return _valeur >= AppValues.compteurMin && _valeur <= AppValues.compteurMax;
  }
}