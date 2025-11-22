// ==========================================
// TESTS UNITAIRES : CompteurController
// ==========================================
// 
// Tests pour valider le controller avec Riverpod
// - Incrémentation/décrémentation
// - Validation des limites
// - Gestion d'erreurs
//
// ==========================================

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:helloworld/controllers/compteur_controller.dart';
import 'package:helloworld/constants/app_values.dart';
import 'package:helloworld/models/compteur_model.dart';

void main() {
  group('CompteurController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('devrait créer un controller avec valeur initiale 0', () {
      final state = container.read(compteurControllerProvider);

      expect(state.valeur, equals(0));
      expect(state.dateCreation, isNotNull);
    });

    test('devrait incrémenter le compteur', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      controller.incrementer();
      final state = container.read(compteurControllerProvider);

      expect(state.valeur, equals(1));
      expect(state.dateModification, isNotNull);
    });

    test('devrait décrémenter le compteur', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      controller.decrementer();
      final state = container.read(compteurControllerProvider);

      expect(state.valeur, equals(-1));
      expect(state.dateModification, isNotNull);
    });

    test('devrait réinitialiser le compteur', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      controller.incrementer();
      controller.incrementer();
      expect(container.read(compteurControllerProvider).valeur, equals(2));
      
      controller.reinitialiser();
      final state = container.read(compteurControllerProvider);

      expect(state.valeur, equals(0));
    });

    test('devrait ne pas dépasser la limite maximale lors de l\'incrémentation', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      // Simuler un compteur à la limite max
      final stateInitial = CompteurModel(valeur: AppValues.compteurMax);
      container.read(compteurControllerProvider.notifier).state = stateInitial;
      
      controller.incrementer();
      final state = container.read(compteurControllerProvider);

      // Ne devrait pas dépasser la limite
      expect(state.valeur, lessThanOrEqualTo(AppValues.compteurMax));
    });

    test('devrait ne pas descendre en dessous de la limite minimale lors de la décrémentation', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      // Simuler un compteur à la limite min
      final stateInitial = CompteurModel(valeur: AppValues.compteurMin);
      container.read(compteurControllerProvider.notifier).state = stateInitial;
      
      controller.decrementer();
      final state = container.read(compteurControllerProvider);

      // Ne devrait pas descendre en dessous de la limite
      expect(state.valeur, greaterThanOrEqualTo(AppValues.compteurMin));
    });

    test('devrait multiplier par 2', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      controller.incrementer(); // Valeur = 1
      controller.incrementer(); // Valeur = 2
      
      controller.multiplierPar2();
      final state = container.read(compteurControllerProvider);

      expect(state.valeur, equals(4));
    });

    test('devrait ne pas multiplier si résultat dépasse la limite max', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      // Simuler un compteur qui multiplierait au-delà de la limite
      final stateInitial = CompteurModel(valeur: AppValues.compteurMax ~/ 2 + 1);
      container.read(compteurControllerProvider.notifier).state = stateInitial;
      
      controller.multiplierPar2();
      final state = container.read(compteurControllerProvider);

      // Ne devrait pas dépasser la limite
      expect(state.valeur, lessThanOrEqualTo(AppValues.compteurMax));
    });

    test('devrait sauvegarder en JSON', () {
      final controller = container.read(compteurControllerProvider.notifier);
      controller.incrementer();
      controller.incrementer();
      
      final json = controller.sauvegarder();

      expect(json['valeur'], equals(2));
      expect(json['dateCreation'], isA<String>());
    });

    test('devrait charger depuis JSON valide', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      final json = {
        'valeur': 42,
        'dateCreation': '2024-01-01T00:00:00',
        'dateModification': null,
      };
      
      controller.charger(json);
      final state = container.read(compteurControllerProvider);

      expect(state.valeur, equals(42));
    });

    test('devrait lever une exception si JSON invalide lors du chargement', () {
      final controller = container.read(compteurControllerProvider.notifier);
      
      final json = {'valeur': 'pas un nombre'};

      expect(
        () => controller.charger(json),
        throwsA(isA<CompteurModelException>()),
      );
    });
  });

  group('compteurValueProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('devrait retourner la valeur du compteur', () {
      final controller = container.read(compteurControllerProvider.notifier);
      controller.incrementer();
      controller.incrementer();
      
      final valeur = container.read(compteurValueProvider);

      expect(valeur, equals(2));
    });
  });

  group('compteurMessageProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('devrait retourner le message pour valeur 0', () {
      final message = container.read(compteurMessageProvider);
      expect(message, contains('commencer'));
    });

    test('devrait retourner le message pour valeur positive', () {
      final controller = container.read(compteurControllerProvider.notifier);
      controller.incrementer();
      
      final message = container.read(compteurMessageProvider);
      expect(message, contains('positif'));
    });

    test('devrait retourner le message pour valeur négative', () {
      final controller = container.read(compteurControllerProvider.notifier);
      controller.decrementer();
      
      final message = container.read(compteurMessageProvider);
      expect(message, contains('négatifs'));
    });
  });
}
