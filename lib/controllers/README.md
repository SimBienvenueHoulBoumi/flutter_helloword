# 🎮 Controllers

## 📋 Description

Ce dossier contient les **controllers** de l'application. Un controller gère la **logique métier** et l'**état** de l'application en utilisant Riverpod.

## 🎯 Qu'est-ce qu'un controller ?

Un controller :
- ✅ Contient la **logique métier** (incrémenter, décrémenter, etc.)
- ✅ Gère l'**état** de l'application (via Riverpod)
- ✅ **Utilise les services** pour les opérations de données
- ✅ Ne contient **pas** d'UI (pas de widgets)
- ✅ Peut être **testé** facilement (service mockable)

## ✅ AMÉLIORATION : Utilisation des services

Le controller utilise maintenant **les services** pour abstraire les opérations de données :
- ✅ Séparation claire des responsabilités
- ✅ Controller plus simple et focalisé
- ✅ Service testable indépendamment
- ✅ Facile d'ajouter une source de données (API, BDD, etc.)

**📖 Voir :** [services/README.md](../services/README.md)

## 📁 Contenu

### `compteur_controller.dart`
Controller qui gère le compteur de l'application.

**Fichier principal :**
- `CompteurController` - Gère l'état et la logique du compteur (utilise le service)
- `compteurServiceProvider` - Provider pour le service de compteur
- `compteurControllerProvider` - Provider Riverpod pour accéder au controller
- `compteurValueProvider` - Provider pour obtenir juste la valeur (int)
- `compteurMessageProvider` - Provider pour obtenir le message selon la valeur

---

## 🔧 Comment utiliser

### Dans un Widget (avec Riverpod)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/compteur_controller.dart';

class MonWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lire la valeur du compteur (rebuild si la valeur change)
    final compteur = ref.watch(compteurValueProvider);
    
    // Obtenir le controller pour appeler ses méthodes
    // Le controller utilise le service en interne
    final controller = ref.read(compteurControllerProvider.notifier);
    
    return Column(
      children: [
        Text('Compteur: $compteur'),
        ElevatedButton(
          onPressed: controller.incrementer,  // Appelle le service via le controller
          child: Text('Incrémenter'),
        ),
      ],
    );
  }
}
```

### Injection de dépendances (Service)

Le controller **utilise le service** via injection de dépendances :

```dart
// Le service est injecté via le provider
late final CompteurService _service;

@override
CompteurModel build() {
  // Injection du service via le provider
  _service = ref.read(compteurServiceProvider);
  return _service.creerCompteur();
}

// Utilisation du service
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

### Méthodes disponibles

#### `incrementer()`
Incrémente le compteur de 1.
```dart
controller.incrementer();  // 0 → 1 → 2 → 3...
```

#### `decrementer()`
Décrémente le compteur de 1.
```dart
controller.decrementer();  // 0 → -1 → -2 → -3...
```

#### `reinitialiser()`
Remet le compteur à zéro.
```dart
controller.reinitialiser();  // Valeur actuelle → 0
```

#### `multiplierPar2()`
Multiplie la valeur du compteur par 2.
```dart
controller.multiplierPar2();  // 5 → 10, 3 → 6
```

#### `sauvegarder()`
Sauvegarde l'état actuel en JSON.
```dart
final json = controller.sauvegarder();
// Retourne: {'valeur': 5, 'dateCreation': '...', ...}
```

#### `charger(Map<String, dynamic> json)`
Charge un état depuis JSON.
```dart
final json = {'valeur': 42, 'dateCreation': '...'};
controller.charger(json);  // Charge l'état
```

---

## 📊 Providers disponibles

### `compteurControllerProvider`
Provider principal qui expose le `CompteurController`.

**Usage :**
```dart
// Obtenir le controller (pour appeler des méthodes)
final controller = ref.read(compteurControllerProvider.notifier);

// Obtenir l'état (CompteurModel)
final state = ref.watch(compteurControllerProvider);
```

### `compteurValueProvider`
Provider qui retourne juste la valeur (int) du compteur.

**Usage :**
```dart
// Plus performant si on n'a besoin que de la valeur
final valeur = ref.watch(compteurValueProvider);  // int
```

### `compteurMessageProvider`
Provider qui retourne le message selon la valeur du compteur.

**Usage :**
```dart
final message = ref.watch(compteurMessageProvider);
// Retourne: 'Appuyez sur + ou - pour commencer !'
//          ou 'Bravo ! Vous comptez en positif 🎉'
//          ou 'Vous êtes dans les négatifs ⚠️'
```

---

## ✅ Validation

Le controller **valide automatiquement** les limites :
- ✅ Ne peut pas dépasser `AppValues.compteurMax` (1000)
- ✅ Ne peut pas descendre en dessous de `AppValues.compteurMin` (-1000)
- ✅ Les méthodes retournent silencieusement si la limite est atteinte

---

## 🧪 Tests

Le controller est **entièrement testé** avec des tests unitaires.

**Voir :** `test/controllers/compteur_controller_test.dart`

**Exemple de test :**
```dart
test('devrait incrémenter le compteur', () {
  final controller = container.read(compteurControllerProvider.notifier);
  controller.incrementer();
  final state = container.read(compteurControllerProvider);
  expect(state.valeur, equals(1));
});
```

---

## 🔄 Créer un nouveau controller

1. **Créer une classe** qui étend `Notifier<MonModele>`
2. **Implémenter `build()`** pour retourner l'état initial
3. **Ajouter les méthodes métier** (sans UI)
4. **Créer le provider** avec `NotifierProvider`
5. **Tester** avec des tests unitaires

**Exemple :**
```dart
class MonController extends Notifier<MonModele> {
  @override
  MonModele build() => MonModele();
  
  void maMethode() {
    state = state.copyWith(...);
  }
}

final monControllerProvider = NotifierProvider<MonController, MonModele>(
  MonController.new,
);
```

---

## 📖 Ressources

- [Riverpod Documentation](https://riverpod.dev)
- [NotifierProvider](https://riverpod.dev/docs/providers/notifier_provider)
- [ConsumerWidget](https://riverpod.dev/docs/concepts/reading)
