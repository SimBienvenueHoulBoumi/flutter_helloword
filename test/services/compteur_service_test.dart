// ==========================================
// TESTS UNITAIRES : CompteurService
// ==========================================
// 
// Tests pour valider le service de compteur
// - Validation des valeurs
// - Calculs des opérations
// - Gestion des limites
//
// ==========================================

import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/services/compteur_service.dart';
import 'package:helloworld/models/compteur_model.dart';
import 'package:helloworld/constants/app_values.dart';

void main() {
  group('CompteurService', () {
    late CompteurService service;

    setUp(() {
      service = CompteurService();
    });

    group('validerValeur', () {
      test('devrait retourner true pour valeur valide', () {
        expect(service.validerValeur(0), isTrue);
        expect(service.validerValeur(500), isTrue);
        expect(service.validerValeur(AppValues.compteurMax), isTrue);
        expect(service.validerValeur(AppValues.compteurMin), isTrue);
      });

      test('devrait retourner false pour valeur invalide', () {
        expect(service.validerValeur(AppValues.compteurMin - 1), isFalse);
        expect(service.validerValeur(AppValues.compteurMax + 1), isFalse);
      });
    });

    group('calculerIncrementation', () {
      test('devrait retourner valeur + 1 si dans limites', () {
        expect(service.calculerIncrementation(0), equals(1));
        expect(service.calculerIncrementation(5), equals(6));
        expect(service.calculerIncrementation(AppValues.compteurMax - 1), equals(AppValues.compteurMax));
      });

      test('devrait retourner null si limite atteinte', () {
        expect(service.calculerIncrementation(AppValues.compteurMax), isNull);
      });
    });

    group('calculerDecrementation', () {
      test('devrait retourner valeur - 1 si dans limites', () {
        expect(service.calculerDecrementation(0), equals(-1));
        expect(service.calculerDecrementation(5), equals(4));
        expect(service.calculerDecrementation(AppValues.compteurMin + 1), equals(AppValues.compteurMin));
      });

      test('devrait retourner null si limite atteinte', () {
        expect(service.calculerDecrementation(AppValues.compteurMin), isNull);
      });
    });

    group('calculerMultiplication', () {
      test('devrait retourner valeur * 2 si dans limites', () {
        expect(service.calculerMultiplication(5), equals(10));
        expect(service.calculerMultiplication(0), equals(0));
      });

      test('devrait retourner null si limite serait dépassée', () {
        expect(service.calculerMultiplication(AppValues.compteurMax ~/ 2 + 1), isNull);
      });
    });

    group('creerCompteur', () {
      test('devrait créer un compteur avec valeur valide', () {
        final model = service.creerCompteur(valeur: 42);
        expect(model.valeur, equals(42));
      });

      test('devrait créer un compteur avec valeur par défaut', () {
        final model = service.creerCompteur();
        expect(model.valeur, equals(0));
      });

      test('devrait lever une exception si valeur invalide', () {
        expect(
          () => service.creerCompteur(valeur: AppValues.compteurMax + 1),
          throwsA(isA<CompteurModelException>()),
        );
      });
    });

    group('mettreAJourValeur', () {
      test('devrait mettre à jour avec valeur valide', () {
        final modelInitial = CompteurModel(valeur: 5);
        final modelNouveau = service.mettreAJourValeur(modelInitial, 10);
        
        expect(modelNouveau, isNotNull);
        expect(modelNouveau!.valeur, equals(10));
        expect(modelNouveau.dateModification, isNotNull);
      });

      test('devrait retourner null si valeur invalide', () {
        final modelInitial = CompteurModel(valeur: 5);
        final modelNouveau = service.mettreAJourValeur(
          modelInitial,
          AppValues.compteurMax + 1,
        );
        
        expect(modelNouveau, isNull);
      });

      test('devrait préserver dateCreation lors de la mise à jour', () {
        final dateCreation = DateTime(2024, 1, 1);
        final modelInitial = CompteurModel(
          valeur: 5,
          dateCreation: dateCreation,
        );
        final modelNouveau = service.mettreAJourValeur(modelInitial, 10);
        
        expect(modelNouveau, isNotNull);
        expect(modelNouveau!.dateCreation, equals(dateCreation));
      });
    });

    group('sauvegarder', () {
      test('devrait sauvegarder un modèle en JSON', () {
        final model = CompteurModel(valeur: 42);
        final json = service.sauvegarder(model);
        
        expect(json['valeur'], equals(42));
        expect(json['dateCreation'], isA<String>());
      });
    });

    group('charger', () {
      test('devrait charger un modèle depuis JSON valide', () {
        final json = {
          'valeur': 42,
          'dateCreation': '2024-01-01T00:00:00',
          'dateModification': null,
        };
        
        final model = service.charger(json);
        
        expect(model.valeur, equals(42));
        expect(model.dateCreation, isNotNull);
      });

      test('devrait lever une exception si JSON invalide', () {
        final json = {'valeur': 'pas un nombre'};
        
        expect(
          () => service.charger(json),
          throwsA(isA<CompteurModelException>()),
        );
      });
    });
  });
}

