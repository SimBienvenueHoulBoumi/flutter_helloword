# 🧩 Widgets

## 📋 Description

Ce dossier contient les **widgets réutilisables** de l'application. Un widget est un composant UI qui peut être utilisé plusieurs fois dans différents écrans.

## 🎯 Qu'est-ce qu'un widget ?

Un widget :
- ✅ Est un **composant UI réutilisable**
- ✅ Peut être utilisé dans **plusieurs écrans**
- ✅ Contient uniquement de l'**UI** (pas de logique métier)
- ✅ Reçoit des **paramètres** pour personnaliser son affichage
- ✅ Peut être **testé** indépendamment

## 📁 Contenu

### `compteur_display.dart`
Widget qui affiche la valeur du compteur avec style.

**Usage :**
```dart
import '../widgets/compteur_display.dart';

CompteurDisplay(compteur: 42)
```

**Paramètres :**
- `compteur` (int, required) - La valeur à afficher

**Fonctionnalités :**
- ✅ Taille de police adaptée (80px)
- ✅ Couleur dynamique selon la valeur (gris/vert/rouge)
- ✅ Accessibilité (Semantics)

---

### `boutons_controle.dart`
Widget qui affiche les boutons de contrôle du compteur.

**Usage :**
```dart
import '../widgets/boutons_controle.dart';

BoutonsControle(
  onIncrementer: () => controller.incrementer(),
  onDecrementer: () => controller.decrementer(),
  onReinitialiser: () => controller.reinitialiser(),
  compteur: valeur,
)
```

**Paramètres :**
- `onIncrementer` (VoidCallback, required) - Callback pour incrémenter
- `onDecrementer` (VoidCallback, required) - Callback pour décrémenter
- `onReinitialiser` (VoidCallback, required) - Callback pour réinitialiser
- `compteur` (int, required) - Valeur actuelle du compteur

**Fonctionnalités :**
- ✅ 3 boutons (+, -, Reset)
- ✅ Couleurs différentes par bouton
- ✅ Accessibilité (Semantics)
- ✅ Espacement cohérent

---

### `message_aide.dart`
Widget qui affiche un message d'aide dynamique selon la valeur du compteur.

**Usage :**
```dart
import '../widgets/message_aide.dart';

MessageAide(compteur: valeur)
```

**Paramètres :**
- `compteur` (int, required) - La valeur du compteur

**Fonctionnalités :**
- ✅ Message dynamique selon la valeur
- ✅ Style cohérent (italique, gris)
- ✅ Accessibilité (Semantics)

---

## 🔧 Comment utiliser

### Dans un écran

```dart
import '../widgets/compteur_display.dart';
import '../widgets/boutons_controle.dart';
import '../widgets/message_aide.dart';

class MonEcran extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final valeur = ref.watch(compteurValueProvider);
    final controller = ref.read(compteurControllerProvider.notifier);
    
    return Scaffold(
      body: Column(
        children: [
          // Utiliser le widget réutilisable
          CompteurDisplay(compteur: valeur),
          
          BoutonsControle(
            onIncrementer: controller.incrementer,
            onDecrementer: controller.decrementer,
            onReinitialiser: controller.reinitialiser,
            compteur: valeur,
          ),
          
          MessageAide(compteur: valeur),
        ],
      ),
    );
  }
}
```

---

## 🎨 Structure d'un widget

Un widget typique :

```dart
import 'package:flutter/material.dart';

/// Description du widget
class MonWidget extends StatelessWidget {
  // Paramètres (final, required)
  final int valeur;
  
  const MonWidget({
    super.key,
    required this.valeur,
  });
  
  @override
  Widget build(BuildContext context) {
    return Semantics(
      // Accessibilité
      label: 'Description pour lecteur d\'écran',
      child: Container(
        // Contenu du widget
        child: Text('Valeur: $valeur'),
      ),
    );
  }
}
```

---

## 🎯 Pourquoi utiliser des widgets réutilisables ?

### ❌ Sans widgets réutilisables (duplication)
```dart
// Dans écran 1
Column(
  children: [
    Text('$compteur', style: TextStyle(fontSize: 80)),
    Row(children: [/* boutons */]),
  ],
)

// Dans écran 2 (duplication !)
Column(
  children: [
    Text('$compteur', style: TextStyle(fontSize: 80)),
    Row(children: [/* boutons */]),
  ],
)
```

### ✅ Avec widgets réutilisables
```dart
// Dans écran 1 et écran 2
Column(
  children: [
    CompteurDisplay(compteur: valeur),
    BoutonsControle(...),
  ],
)
```

**Avantages :**
- ✅ Code réutilisable
- ✅ Maintenance facile (modifier une fois, appliqué partout)
- ✅ Tests plus simples
- ✅ Cohérence visuelle

---

## 🧪 Tests

Les widgets peuvent être **testés** avec des tests widget.

**Exemple de test :**
```dart
testWidgets('CompteurDisplay affiche la valeur', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: CompteurDisplay(compteur: 42),
    ),
  );
  
  expect(find.text('42'), findsOneWidget);
});
```

---

## 🔄 Créer un nouveau widget

1. **Créer le fichier** dans `widgets/` (ex: `mon_widget.dart`)
2. **Créer une classe** qui étend `StatelessWidget` (ou `ConsumerWidget` si besoin de Riverpod)
3. **Définir les paramètres** (final, required)
4. **Implémenter `build()`** avec le contenu UI
5. **Ajouter l'accessibilité** (Semantics)
6. **Utiliser les constantes** (AppSpacing, AppColors, etc.)
7. **Tester** si nécessaire

**Exemple :**
```dart
import 'package:flutter/material.dart';
import '../constants/app_spacing.dart';

/// Widget qui affiche [description]
class MonWidget extends StatelessWidget {
  final String titre;
  
  const MonWidget({
    super.key,
    required this.titre,
  });
  
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: titre,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Text(titre),
      ),
    );
  }
}
```

---

## 📖 Bonnes pratiques

### ✅ À FAIRE
- Utiliser `const` quand possible (performance)
- Utiliser les constantes (AppSpacing, AppColors, etc.)
- Ajouter l'accessibilité (Semantics)
- Documenter avec des commentaires
- Garder les widgets simples et focalisés
- Utiliser `ConsumerWidget` si besoin de Riverpod

### ❌ À ÉVITER
- Mettre de la logique métier (utiliser un controller)
- Utiliser des "magic numbers" (utiliser les constantes)
- Dupliquer le code (créer un widget réutilisable)
- Widgets trop complexes (diviser en plusieurs widgets)

---

## 📖 Ressources

- [Flutter Widgets](https://docs.flutter.dev/development/ui/widgets)
- [Creating Reusable Widgets](https://docs.flutter.dev/development/ui/widgets-intro)
- [Accessibility in Flutter](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)
