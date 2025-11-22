# 🛠️ Utils

## 📋 Description

Ce dossier contient les **utilitaires** (Utils) de l'application. Les utilitaires sont des fonctions et classes **statiques** qui fournissent des fonctionnalités réutilisables.

## 🎯 Qu'est-ce qu'un utilitaire ?

Un utilitaire :
- ✅ Contient des **fonctions statiques** (pas d'instance)
- ✅ Fournit des **fonctionnalités réutilisables**
- ✅ Ne contient **pas** de logique métier complexe
- ✅ Peut être utilisé **partout** dans l'application
- ✅ Évite la **duplication de code**

## 📁 Contenu

### `compteur_utils.dart`
Utilitaires pour le compteur (messages, couleurs, validation).

**Fonctions disponibles :**

#### `getMessage(int valeur)`
Retourne un message selon la valeur du compteur.

```dart
import '../utils/compteur_utils.dart';

final message = CompteurUtils.getMessage(0);
// Retourne: 'Appuyez sur + ou - pour commencer !'

final message2 = CompteurUtils.getMessage(5);
// Retourne: 'Bravo ! Vous comptez en positif 🎉'

final message3 = CompteurUtils.getMessage(-5);
// Retourne: 'Vous êtes dans les négatifs ⚠️'
```

#### `getCouleur(int valeur)`
Retourne une couleur selon la valeur du compteur.

```dart
import '../utils/compteur_utils.dart';
import 'package:flutter/material.dart';

final couleur = CompteurUtils.getCouleur(0);
// Retourne: Colors.grey

final couleur2 = CompteurUtils.getCouleur(5);
// Retourne: Colors.green

final couleur3 = CompteurUtils.getCouleur(-5);
// Retourne: Colors.red
```

#### `peutIncrementer(int valeur)`
Vérifie si on peut incrémenter sans dépasser la limite max.

```dart
if (CompteurUtils.peutIncrementer(valeur)) {
  // Peut incrémenter
} else {
  // Limite max atteinte
}
```

#### `peutDecrementer(int valeur)`
Vérifie si on peut décrémenter sans descendre en dessous du min.

```dart
if (CompteurUtils.peutDecrementer(valeur)) {
  // Peut décrémenter
} else {
  // Limite min atteinte
}
```

---

### `date_formatter.dart`
Utilitaires pour formater les dates.

**Fonctions disponibles :**

#### `formatDateCourte(DateTime date)`
Formate une date en format court (JJ/MM/AAAA HH:MM:SS).

```dart
import '../utils/date_formatter.dart';

final date = DateTime(2024, 1, 15, 14, 30, 45);
final formatted = DateFormatter.formatDateCourte(date);
// Retourne: '15/01/2024 14:30:45'
```

#### `formatDateISO(DateTime date)`
Formate une date en format ISO court (sans millisecondes).

```dart
final formatted = DateFormatter.formatDateISO(date);
// Retourne: '2024-01-15T14:30:45'
```

#### `formatDateAffichage(DateTime date)`
Formate une date pour l'affichage dans l'UI.

```dart
final formatted = DateFormatter.formatDateAffichage(date);
// Retourne: '2024/01/15 14:30:45'
```

#### `formatDateNullable(DateTime? date)`
Formate une date nullable (retourne 'Non modifié' si null).

```dart
final formatted1 = DateFormatter.formatDateNullable(null);
// Retourne: 'Non modifié'

final formatted2 = DateFormatter.formatDateNullable(DateTime.now());
// Retourne: '2024/01/15 14:30:45'
```

---

## 🔧 Comment utiliser

### Import
```dart
import '../utils/compteur_utils.dart';
import '../utils/date_formatter.dart';
```

### Utilisation directe
```dart
// Toutes les méthodes sont statiques, pas besoin d'instance
final message = CompteurUtils.getMessage(5);
final couleur = CompteurUtils.getCouleur(5);
final formatted = DateFormatter.formatDateAffichage(DateTime.now());
```

---

## 🎯 Pourquoi utiliser les utilitaires ?

### ❌ Sans utilitaires (duplication)
```dart
// Dans widget 1
String getMessage(int valeur) {
  if (valeur == 0) return 'Commencez !';
  if (valeur > 0) return 'Positif !';
  return 'Négatif !';
}

// Dans widget 2 (duplication !)
String getMessage(int valeur) {
  if (valeur == 0) return 'Commencez !';
  if (valeur > 0) return 'Positif !';
  return 'Négatif !';
}
```

### ✅ Avec utilitaires (réutilisable)
```dart
// Dans CompteurUtils (une seule fois)
static String getMessage(int valeur) {
  if (valeur == 0) return 'Commencez !';
  if (valeur > 0) return 'Positif !';
  return 'Négatif !';
}

// Dans widget 1 et widget 2
final message = CompteurUtils.getMessage(valeur);
```

---

## 🧪 Tests

Les utilitaires sont **entièrement testés** avec des tests unitaires.

**Voir :**
- `test/utils/compteur_utils_test.dart`
- `test/utils/date_formatter_test.dart`

---

## 🔄 Créer un nouvel utilitaire

1. **Créer le fichier** dans `utils/` (ex: `mon_utilitaire.dart`)
2. **Créer une classe** avec constructeur privé
3. **Ajouter des méthodes statiques**
4. **Documenter** chaque méthode
5. **Tester** avec des tests unitaires

**Exemple :**
```dart
/// Utilitaires pour [description]
class MonUtilitaire {
  MonUtilitaire._(); // Constructeur privé pour empêcher l'instanciation
  
  /// [Description de la méthode]
  static String maMethode(String input) {
    // Implémentation
    return input.toUpperCase();
  }
}
```

---

## 📖 Bonnes pratiques

### ✅ À FAIRE
- Utiliser des méthodes statiques
- Rendre la classe non instanciable (constructeur privé)
- Documenter chaque méthode
- Tester toutes les méthodes
- Garder les méthodes simples et focalisées

### ❌ À ÉVITER
- Mettre de la logique métier complexe (utiliser un controller)
- Créer des instances (tout est statique)
- Dupliquer le code (utiliser les utilitaires)
- Méthodes trop longues ou complexes

---

## 📖 Ressources

- [Dart Static Methods](https://dart.dev/guides/language/language-tour#class-variables-and-methods)
- [Flutter Best Practices](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
