// ==========================================
// TESTS UNITAIRES : DateFormatter
// ==========================================
// 
// Tests pour valider le formatage des dates
//
// ==========================================

import 'package:flutter_test/flutter_test.dart';
import 'package:helloworld/utils/date_formatter.dart';

void main() {
  group('DateFormatter', () {
    final date = DateTime(2024, 1, 15, 14, 30, 45);

    group('formatDateCourte', () {
      test('devrait formater une date en format court', () {
        final formatted = DateFormatter.formatDateCourte(date);
        expect(formatted, contains('15'));
        expect(formatted, contains('01'));
        expect(formatted, contains('2024'));
        expect(formatted, contains(':'));
      });

      test('devrait ajouter un zéro devant les nombres < 10', () {
        final dateMin = DateTime(2024, 1, 5, 3, 5, 7);
        final formatted = DateFormatter.formatDateCourte(dateMin);
        expect(formatted, contains('05/01'));
        expect(formatted, contains('03:05'));
      });
    });

    group('formatDateISO', () {
      test('devrait formater une date en format ISO court', () {
        final formatted = DateFormatter.formatDateISO(date);
        expect(formatted.length, equals(19));
        expect(formatted, contains('2024-01-15'));
        expect(formatted, contains('14:30:45'));
      });
    });

    group('formatDateAffichage', () {
      test('devrait formater une date pour l\'affichage', () {
        final formatted = DateFormatter.formatDateAffichage(date);
        expect(formatted, contains('2024/01/15'));
        expect(formatted, contains(' ')); // Espace au lieu de T
        expect(formatted, contains('14:30:45'));
      });
    });

    group('formatDateNullable', () {
      test('devrait retourner "Non modifié" si date est null', () {
        final formatted = DateFormatter.formatDateNullable(null);
        expect(formatted, equals('Non modifié'));
      });

      test('devrait formater la date si elle n\'est pas null', () {
        final formatted = DateFormatter.formatDateNullable(date);
        expect(formatted, isNot(equals('Non modifié')));
        expect(formatted, contains('2024'));
      });
    });
  });
}
