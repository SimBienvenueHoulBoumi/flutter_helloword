# 🔧 Services

## 📋 Description

Ce dossier contient les **services** de l'application. Un service abstrait les opérations de données et sépare la logique métier (controller) de la gestion des données.

## 🎯 Qu'est-ce qu'un service ?

Un service :
- ✅ Abstrait les **opérations de données**
- ✅ Sépare la **logique métier** (controller) de la **gestion des données**
- ✅ Facilite les **tests** (mockable)
- ✅ Facilite l'ajout d'une **source de données** (API, BDD, etc.)
- ✅ Est **réutilisable** dans différents controllers

## 📁 Contenu

### `compteur_service.dart`
Service qui gère les opérations de données du compteur.

**Méthodes principales :**
- `validerValeur()` - Valide une valeur de compteur
- `calculerIncrementation()` - Calcule la nouvelle valeur après incrémentation
- `calculerDecrementation()` - Calcule la nouvelle valeur après décrémentation
- `calculerMultiplication()` - Calcule la nouvelle valeur après multiplication
- `creerCompteur()` - Crée un nouveau modèle de compteur validé
- `mettreAJourValeur()` - Met à jour un modèle avec une nouvelle valeur
- `sauvegarder()` - Sauvegarde un modèle en JSON
- `charger()` - Charge un modèle depuis JSON

---

### `error_handler.dart`
Service global pour gérer les erreurs de l'application.

**Fonctionnalités :**
- ✅ Gestion centralisée des erreurs
- ✅ Messages d'erreur cohérents
- ✅ Affichage automatique (Snackbar ou Dialog)
- ✅ Logging des erreurs
- ✅ Classification des erreurs (validation, réseau, stockage, inconnu)

**Méthodes principales :**
- `gererErreur()` - Gère une exception et affiche un message
- `afficherErreur()` - Affiche une erreur via Snackbar
- `afficherErreurDialog()` - Affiche une erreur via Dialog
- `loggerErreur()` - Log une erreur (pourrait être étendu pour Sentry, Firebase, etc.)

---

## 🔧 Comment utiliser

### Service de compteur

```dart
import '../services/compteur_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dans un controller
class MonController extends Notifier<MonModele> {
  late final CompteurService _service;
  
  @override
  MonModele build() {
    // Injection du service via provider
    _service = ref.read(compteurServiceProvider);
    return MonModele();
  }
  
  void incrementer() {
    final nouvelleValeur = _service.calculerIncrementation(state.valeur);
    if (nouvelleValeur != null) {
      final nouveauModele = _service.mettreAJourValeur(state, nouvelleValeur);
      if (nouveauModele != null) {
        state = nouveauModele;
      }
    }
  }
}

// Provider pour le service
final compteurServiceProvider = Provider<CompteurService>((ref) {
  return CompteurService();
});
```

### Gestionnaire d'erreurs

```dart
import '../services/error_handler.dart';

// Dans un écran ou widget
try {
  // Opération qui peut échouer
  controller.incrementer();
} catch (e) {
  // Gestion automatique de l'erreur
  ErrorHandler.gererErreur(context, e);
}

// Ou afficher une erreur directement
final erreur = ErreurApplication(
  type: TypeErreur.validation,
  message: 'Valeur invalide',
);
ErrorHandler.afficherErreur(context, erreur);
```

---

## ✅ Avantages de cette architecture

### Avant (sans service)
```dart
// Dans le controller - logique mélangée
void incrementer() {
  if (state.valeur >= AppValues.compteurMax) {
    return; // Validation dans le controller
  }
  state = state.copyWith(valeur: state.valeur + 1); // Logique dans le controller
}
```

### Après (avec service)
```dart
// Dans le controller - logique découplée
void incrementer() {
  final nouvelleValeur = _service.calculerIncrementation(state.valeur);
  if (nouvelleValeur != null) {
    final nouveauModele = _service.mettreAJourValeur(state, nouvelleValeur);
    if (nouveauModele != null) {
      state = nouveauModele;
    }
  }
}
```

**Avantages** :
- ✅ Séparation claire des responsabilités
- ✅ Controller plus simple et focalisé
- ✅ Service testable indépendamment
- ✅ Facile d'ajouter une source de données (API, BDD)

---

## 🔄 Flux de données avec Service

```
┌─────────────────────────────────────┐
│         SCREENS (UI)                │
│    - Affiche l'interface            │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│      CONTROLLERS (Logique)          │
│    - Gère l'état (Riverpod)         │
│    - Utilise les services           │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│         SERVICES (Données)          │
│    - Abstrait les opérations        │
│    - Validation et calculs          │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│         MODELS (Données)            │
│    - Structure des données          │
│    - Validation + sérialisation     │
└─────────────────────────────────────┘
```

---

## 🧪 Tests

Les services sont **entièrement testables** et peuvent être **mockés** facilement.

**Voir :** `test/services/compteur_service_test.dart`

**Exemple de test :**
```dart
test('devrait calculer l\'incrémentation correctement', () {
  final service = CompteurService();
  final nouvelleValeur = service.calculerIncrementation(5);
  expect(nouvelleValeur, equals(6));
});
```

---

## 🔄 Créer un nouveau service

1. **Créer le fichier** dans `services/` (ex: `mon_service.dart`)
2. **Créer une classe** avec les méthodes nécessaires
3. **Créer le provider** Riverpod pour l'injection
4. **Utiliser le service** dans les controllers
5. **Tester** avec des tests unitaires

**Exemple :**
```dart
class MonService {
  // Méthodes du service
  String traiterDonnee(String donnee) {
    // Logique de traitement
    return donnee.toUpperCase();
  }
}

// Provider pour le service
final monServiceProvider = Provider<MonService>((ref) {
  return MonService();
});
```

---

## 📖 Bonnes pratiques

### ✅ À FAIRE
- Abstraire les opérations de données dans les services
- Utiliser les services dans les controllers (injection de dépendances)
- Rendre les services testables et mockables
- Centraliser la gestion d'erreurs via ErrorHandler
- Documenter chaque méthode du service

### ❌ À ÉVITER
- Mettre de la logique UI dans les services
- Mettre de la logique métier complexe dans les services (utiliser les controllers)
- Mélanger les responsabilités (service = données uniquement)
- Créer des services trop complexes (diviser en plusieurs services)

---

## 📖 Ressources

- [Dependency Injection in Flutter](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
- [Service Layer Pattern](https://en.wikipedia.org/wiki/Service_layer_pattern)
- [Riverpod Providers](https://riverpod.dev/docs/concepts/about_providers)
