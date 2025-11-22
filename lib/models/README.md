# 📊 Models

## 📋 Description

Ce dossier contient les **modèles de données** (Models) de l'application. Un modèle représente la **structure des données** et **pas** la logique métier.

## 🎯 Qu'est-ce qu'un modèle ?

Un modèle :
- ✅ Définit la **structure des données** (propriétés)
- ✅ Gère la **sérialisation/désérialisation** (JSON)
- ✅ Contient la **validation** des données
- ✅ Est **immuable** (ne change pas, on crée une copie)
- ✅ Ne contient **pas** de logique métier

## 📁 Contenu

### `compteur_model.dart`
Modèle qui représente l'état d'un compteur.

**Propriétés :**
- `valeur` (int) - La valeur actuelle du compteur
- `dateCreation` (DateTime) - Date de création du compteur
- `dateModification` (DateTime?) - Date de dernière modification (nullable)

**Méthodes principales :**
- `copyWith()` - Crée une copie avec des valeurs modifiées
- `toJson()` - Convertit en JSON
- `fromJson()` - Crée depuis JSON (avec validation)
- `isValid()` - Vérifie si la valeur est dans les limites

---

### `session_compteur.dart`
Modèle qui représente une session de compteur sauvegardée.

**Propriétés :**
- `id` (String) - Identifiant unique de la session
- `nom` (String?) - Nom optionnel de la session
- `valeurFinale` (int) - Valeur finale du compteur
- `dateSession` (DateTime) - Date de la session

---

## 🔧 Comment utiliser

### Créer un modèle

```dart
import '../models/compteur_model.dart';

// Créer avec valeur par défaut (0)
final model = CompteurModel();

// Créer avec une valeur spécifique
final model2 = CompteurModel(valeur: 42);

// Créer avec toutes les propriétés
final model3 = CompteurModel(
  valeur: 10,
  dateCreation: DateTime(2024, 1, 1),
  dateModification: DateTime.now(),
);
```

### Lire les propriétés

```dart
final valeur = model.valeur;  // int
final dateCreation = model.dateCreation;  // DateTime
final dateModification = model.dateModification;  // DateTime?
```

### Créer une copie modifiée

```dart
// Créer une copie avec une nouvelle valeur
final copie = model.copyWith(valeur: 50);

// L'original n'est pas modifié
print(model.valeur);  // 42
print(copie.valeur);  // 50
```

### Sérialisation JSON

#### Convertir en JSON
```dart
final json = model.toJson();
// Retourne: {
//   'valeur': 42,
//   'dateCreation': '2024-01-01T00:00:00',
//   'dateModification': '2024-01-02T00:00:00'
// }
```

#### Créer depuis JSON
```dart
final json = {
  'valeur': 42,
  'dateCreation': '2024-01-01T00:00:00',
};

final model = CompteurModel.fromJson(json);
print(model.valeur);  // 42
```

---

## ✅ Validation

Les modèles **valident automatiquement** les données :

### Validation à la création
```dart
// ✅ Accepté : dans les limites
final model1 = CompteurModel(valeur: 500);  // OK

// ❌ Erreur : en dessous du minimum
final model2 = CompteurModel(valeur: -1001);  
// Lève: CompteurModelException

// ❌ Erreur : au-dessus du maximum
final model3 = CompteurModel(valeur: 1001);  
// Lève: CompteurModelException
```

### Validation lors du parsing JSON
```dart
// ✅ JSON valide
final json1 = {'valeur': 42};
final model1 = CompteurModel.fromJson(json1);  // OK

// ❌ Valeur invalide
final json2 = {'valeur': 'pas un nombre'};
final model2 = CompteurModel.fromJson(json2);
// Lève: CompteurModelException

// ❌ Date invalide
final json3 = {'valeur': 42, 'dateCreation': 'date invalide'};
final model3 = CompteurModel.fromJson(json3);
// Lève: CompteurModelException
```

### Vérifier si un modèle est valide
```dart
final model = CompteurModel(valeur: 500);
if (model.isValid()) {
  print('Modèle valide !');
}
```

---

## 🛡️ Gestion d'erreurs

Le modèle utilise des **exceptions personnalisées** pour les erreurs :

```dart
try {
  final model = CompteurModel.fromJson(json);
} on CompteurModelException catch (e) {
  print('Erreur: ${e.message}');
  // Gérer l'erreur
}
```

---

## 🧪 Tests

Les modèles sont **entièrement testés** avec des tests unitaires.

**Voir :** `test/models/compteur_model_test.dart`

**Exemples de tests :**
- ✅ Création avec valeurs par défaut
- ✅ Validation des limites
- ✅ Sérialisation/désérialisation JSON
- ✅ Gestion d'erreurs
- ✅ Comparaison de modèles

---

## 🔄 Créer un nouveau modèle

1. **Définir les propriétés** (final, privées)
2. **Créer le constructeur** avec validation
3. **Ajouter les getters** publics
4. **Implémenter `copyWith()`** pour l'immuabilité
5. **Implémenter `toJson()` et `fromJson()`** pour la sérialisation
6. **Ajouter la validation** dans `fromJson()`
7. **Tester** avec des tests unitaires

**Exemple :**
```dart
class MonModele {
  final int _valeur;
  
  MonModele({int valeur = 0}) : _valeur = _validateValeur(valeur);
  
  int get valeur => _valeur;
  
  MonModele copyWith({int? valeur}) {
    return MonModele(valeur: valeur ?? _valeur);
  }
  
  Map<String, dynamic> toJson() => {'valeur': _valeur};
  
  factory MonModele.fromJson(Map<String, dynamic> json) {
    // Validation ici
    return MonModele(valeur: json['valeur'] as int);
  }
  
  static int _validateValeur(int valeur) {
    if (valeur < 0) throw Exception('Valeur invalide');
    return valeur;
  }
}
```

---

## 📖 Ressources

- [Flutter Data Classes](https://dart.dev/guides/language/effective-dart/design#types)
- [JSON Serialization](https://docs.flutter.dev/development/data-and-backend/json)
- [Immutability in Dart](https://dart.dev/guides/language/effective-dart/design#avoid-mutating-parameters)
