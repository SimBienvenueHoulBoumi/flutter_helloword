// ==========================================
// TESTS UNITAIRES : CompteurModel
// ==========================================
// 
// Tests pour valider le modèle CompteurModel
// - Validation des données
// - Gestion d'erreurs
// - Sérialisation JSON
//
// ==========================================

import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/models/compteur_model.dart';
import 'package:helloworld/constants/app_values.dart';

void main() {
  group('CompteurModel', () {
    test('devrait créer un modèle avec la valeur par défaut (0)', () {
      final model = CompteurModel();
      expect(model.valeur, equals(0));
      expect(model.dateCreation, isNotNull);
      expect(model.dateModification, isNull);
    });

    test('devrait créer un modèle avec une valeur spécifique', () {
      final model = CompteurModel(valeur: 10);
      expect(model.valeur, equals(10));
      expect(model.isValid(), isTrue);
    });

    test('devrait valider les limites minimales', () {
      final model = CompteurModel(valeur: AppValues.compteurMin);
      expect(model.valeur, equals(AppValues.compteurMin));
      expect(model.isValid(), isTrue);
    });

    test('devrait valider les limites maximales', () {
      final model = CompteurModel(valeur: AppValues.compteurMax);
      expect(model.valeur, equals(AppValues.compteurMax));
      expect(model.isValid(), isTrue);
    });

    test('devrait lever une exception si valeur < limite minimale', () {
      expect(
        () => CompteurModel(valeur: AppValues.compteurMin - 1),
        throwsA(isA<CompteurModelException>()),
      );
    });

    test('devrait lever une exception si valeur > limite maximale', () {
      expect(
        () => CompteurModel(valeur: AppValues.compteurMax + 1),
        throwsA(isA<CompteurModelException>()),
      );
    });

    test('devrait créer une copie avec copyWith', () {
      final original = CompteurModel(valeur: 5);
      final copie = original.copyWith(valeur: 10);
      
      expect(copie.valeur, equals(10));
      expect(original.valeur, equals(5)); // Original non modifié
      expect(copie.dateCreation, equals(original.dateCreation));
    });

    test('devrait sérialiser en JSON', () {
      final model = CompteurModel(valeur: 42);
      final json = model.toJson();
      
      expect(json['valeur'], equals(42));
      expect(json['dateCreation'], isA<String>());
      expect(json['dateModification'], isNull);
    });

    test('devrait désérialiser depuis JSON valide', () {
      final json = {
        'valeur': 42,
        'dateCreation': '2024-01-01T00:00:00',
        'dateModification': null,
      };
      
      final model = CompteurModel.fromJson(json);
      
      expect(model.valeur, equals(42));
      expect(model.dateCreation, isNotNull);
      expect(model.dateModification, isNull);
    });

    test('devrait créer un modèle par défaut si JSON vide', () {
      final json = <String, dynamic>{};
      final model = CompteurModel.fromJson(json);
      
      expect(model.valeur, equals(AppValues.compteurValeurInitiale));
    });

    test('devrait lever une exception si valeur JSON invalide', () {
      final json = {'valeur': 'pas un nombre'};
      
      expect(
        () => CompteurModel.fromJson(json),
        throwsA(isA<CompteurModelException>()),
      );
    });

    test('devrait lever une exception si date JSON invalide', () {
      final json = {
        'valeur': 42,
        'dateCreation': 'date invalide',
      };
      
      expect(
        () => CompteurModel.fromJson(json),
        throwsA(isA<CompteurModelException>()),
      );
    });

    test('devrait lever une exception si valeur hors limites dans JSON', () {
      final json = {'valeur': AppValues.compteurMax + 1};
      
      expect(
        () => CompteurModel.fromJson(json),
        throwsA(isA<CompteurModelException>()),
      );
    });

    test('devrait comparer deux modèles égaux', () {
      final date = DateTime.now();
      final model1 = CompteurModel(valeur: 5, dateCreation: date);
      final model2 = CompteurModel(valeur: 5, dateCreation: date);
      
      expect(model1 == model2, isTrue);
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('devrait comparer deux modèles différents', () {
      final model1 = CompteurModel(valeur: 5);
      final model2 = CompteurModel(valeur: 10);
      
      expect(model1 == model2, isFalse);
    });

    test('devrait retourner une représentation textuelle', () {
      final model = CompteurModel(valeur: 42);
      final str = model.toString();
      
      expect(str, contains('42'));
      expect(str, contains('CompteurModel'));
    });
  });
}
