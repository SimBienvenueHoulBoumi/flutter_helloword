# 📱 Screens

## 📋 Description

Ce dossier contient les **écrans** (Screens) de l'application. Un écran est une page complète de l'application qui utilise des widgets pour afficher l'interface utilisateur.

## 🎯 Qu'est-ce qu'un écran ?

Un écran :
- ✅ Est une **page complète** de l'application
- ✅ Contient l'**UI** (widgets, layout)
- ✅ Utilise les **controllers** pour la logique (via Riverpod)
- ✅ Utilise les **widgets** réutilisables
- ✅ Utilise la **navigation** pour changer de page

## 📁 Contenu

### `ecran_accueil.dart`
Écran principal de l'application avec le compteur.

**Fonctionnalités :**
- ✅ Affichage du compteur
- ✅ Boutons de contrôle (+ / - / Reset)
- ✅ Message d'aide dynamique
- ✅ Affichage des dates de création/modification
- ✅ Navigation vers l'écran "À propos"
- ✅ FloatingActionButton pour incrémenter

**Widgets utilisés :**
- `CompteurDisplay` - Affiche la valeur du compteur
- `BoutonsControle` - Boutons + / - / Reset
- `MessageAide` - Message dynamique selon la valeur

**Providers utilisés :**
- `compteurControllerProvider` - Pour accéder au controller
- `compteurValueProvider` - Pour obtenir la valeur
- `compteurMessageProvider` - Pour obtenir le message

---

### `ecran_a_propos.dart`
Écran "À propos" qui affiche les informations sur l'application.

**Fonctionnalités :**
- ✅ Description de l'application
- ✅ Technologies utilisées
- ✅ Architecture de l'application
- ✅ Version de l'application

**Navigation :**
- ✅ Retour automatique via AppBar (bouton ←)

---

## 🔧 Comment utiliser

### Créer un écran avec Riverpod

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/compteur_controller.dart';

class MonEcran extends ConsumerWidget {
  const MonEcran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Accéder aux providers
    final valeur = ref.watch(compteurValueProvider);
    final controller = ref.read(compteurControllerProvider.notifier);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Écran')),
      body: Center(
        child: Column(
          children: [
            Text('Valeur: $valeur'),
            ElevatedButton(
              onPressed: controller.incrementer,
              child: const Text('Incrémenter'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### Navigation entre écrans

#### Navigation avec route nommée (Recommandé)
```dart
import '../constants/app_routes.dart';

// Aller à un autre écran
Navigator.of(context).pushNamed(AppRoutes.aPropos);

// Retourner
Navigator.of(context).pop();
```

#### Navigation avec MaterialPageRoute
```dart
import 'ecran_a_propos.dart';

Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const EcranAPropos(),
  ),
);
```

---

## 📱 Structure d'un écran

Un écran typique contient :

```dart
class MonEcran extends ConsumerWidget {
  const MonEcran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // AppBar : Barre en haut
      appBar: AppBar(
        title: const Text('Titre'),
      ),
      
      // Body : Contenu principal
      body: Center(
        child: Column(
          children: [
            // Vos widgets ici
          ],
        ),
      ),
      
      // FloatingActionButton (optionnel)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

---

## 🎨 Bonnes pratiques

### ✅ À FAIRE
- Utiliser `ConsumerWidget` pour accéder aux providers
- Utiliser `ref.watch()` pour lire les valeurs (rebuild automatique)
- Utiliser `ref.read()` pour appeler les méthodes (pas de rebuild)
- Utiliser les routes nommées pour la navigation
- Utiliser les widgets réutilisables du dossier `widgets/`
- Utiliser les constantes du dossier `constants/`

### ❌ À ÉVITER
- Mettre la logique métier directement dans l'écran
- Utiliser des "magic numbers" (utiliser les constantes)
- Dupliquer le code (utiliser les widgets réutilisables)
- Navigation complexe (utiliser les routes nommées)

---

## 🔄 Créer un nouvel écran

1. **Créer le fichier** dans `screens/` (ex: `ecran_mon_ecran.dart`)
2. **Créer la classe** qui étend `ConsumerWidget`
3. **Implémenter `build()`** avec `Scaffold`
4. **Ajouter la route** dans `constants/app_routes.dart`
5. **Enregistrer la route** dans `app.dart`

**Exemple :**
```dart
// 1. Créer l'écran
class MonEcran extends ConsumerWidget {
  const MonEcran({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mon Écran')),
      body: const Center(child: Text('Contenu')),
    );
  }
}

// 2. Ajouter la route dans app_routes.dart
static const String monEcran = '/mon-ecran';

// 3. Enregistrer dans app.dart
routes: {
  AppRoutes.monEcran: (context) => const MonEcran(),
}
```

---

## 📖 Ressources

- [Flutter Screens](https://docs.flutter.dev/development/ui/widgets)
- [Riverpod ConsumerWidget](https://riverpod.dev/docs/concepts/reading)
- [Navigation in Flutter](https://docs.flutter.dev/cookbook/navigation)
