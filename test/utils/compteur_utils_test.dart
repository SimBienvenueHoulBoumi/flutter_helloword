// ==========================================
// TESTS UNITAIRES : CompteurUtils
// ==========================================
// 
// Tests pour valider les utilitaires du compteur
//
// ==========================================

import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/utils/compteur_utils.dart';
import 'package:helloworld/constants/app_values.dart';
import 'package:helloworld/constants/app_colors.dart';

void main() {
  group('CompteurUtils', () {
    group('getMessage', () {
      test('devrait retourner le message pour valeur 0', () {
        final message = CompteurUtils.getMessage(0);
        expect(message, contains('commencer'));
      });

      test('devrait retourner le message pour valeur positive', () {
        final message = CompteurUtils.getMessage(5);
        expect(message, contains('positif'));
      });

      test('devrait retourner le message pour valeur négative', () {
        final message = CompteurUtils.getMessage(-5);
        expect(message, contains('négatifs'));
      });

      test('devrait retourner le message spécial pour le seuil', () {
        final message = CompteurUtils.getMessage(AppValues.compteurValeurSeuil);
        expect(message, contains('${AppValues.compteurValeurSeuil}'));
      });
    });

    group('getCouleur', () {
      test('devrait retourner la couleur grise pour valeur 0', () {
        final couleur = CompteurUtils.getCouleur(0);
        expect(couleur, equals(AppColors.compteurZero));
      });

      test('devrait retourner la couleur verte pour valeur positive', () {
        final couleur = CompteurUtils.getCouleur(5);
        expect(couleur, equals(AppColors.compteurPositif));
      });

      test('devrait retourner la couleur rouge pour valeur négative', () {
        final couleur = CompteurUtils.getCouleur(-5);
        expect(couleur, equals(AppColors.compteurNegatif));
      });
    });

    group('peutIncrementer', () {
      test('devrait retourner true si valeur < max', () {
        expect(CompteurUtils.peutIncrementer(5), isTrue);
        expect(CompteurUtils.peutIncrementer(AppValues.compteurMax - 1), isTrue);
      });

      test('devrait retourner false si valeur >= max', () {
        expect(CompteurUtils.peutIncrementer(AppValues.compteurMax), isFalse);
        expect(CompteurUtils.peutIncrementer(AppValues.compteurMax + 1), isFalse);
      });
    });

    group('peutDecrementer', () {
      test('devrait retourner true si valeur > min', () {
        expect(CompteurUtils.peutDecrementer(5), isTrue);
        expect(CompteurUtils.peutDecrementer(AppValues.compteurMin + 1), isTrue);
      });

      test('devrait retourner false si valeur <= min', () {
        expect(CompteurUtils.peutDecrementer(AppValues.compteurMin), isFalse);
        expect(CompteurUtils.peutDecrementer(AppValues.compteurMin - 1), isFalse);
      });
    });
  });
}
