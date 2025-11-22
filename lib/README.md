# 📂 Structure du code source (lib/)

## 📋 Description

Ce dossier contient tout le **code source** de l'application Flutter. Il est organisé en dossiers selon l'architecture recommandée par Google Flutter.

## 🏗️ Architecture

L'application suit une **architecture modulaire** avec séparation des responsabilités :

```
lib/
├── main.dart              # Point d'entrée de l'application
├── app.dart               # Configuration de l'application (MaterialApp, routes)
│
├── constants/             # 📦 Constantes (espacements, couleurs, valeurs)
│   ├── app_spacing.dart
│   ├── app_text_styles.dart
│   ├── app_colors.dart
│   ├── app_values.dart
│   └── app_routes.dart
│
├── models/                # 📊 Modèles de données (structure des données)
│   ├── compteur_model.dart
│   └── session_compteur.dart
│
├── controllers/           # 🎮 Controllers (logique métier + état Riverpod)
│   └── compteur_controller.dart
│
├── services/              # 🔧 Services (abstraction des opérations de données)
│   ├── compteur_service.dart
│   └── error_handler.dart
│
├── utils/                 # 🛠️ Utilitaires (fonctions statiques réutilisables)
│   ├── compteur_utils.dart
│   └── date_formatter.dart
│
├── widgets/               # 🧩 Widgets réutilisables (composants UI)
│   ├── compteur_display.dart
│   ├── boutons_controle.dart
│   └── message_aide.dart
│
└── screens/               # 📱 Écrans (pages complètes de l'application)
    ├── ecran_accueil.dart
    └── ecran_a_propos.dart
```

---

## 📁 Organisation des dossiers

### 📦 `constants/`
Contient toutes les **constantes** de l'application.
- ✅ Espacements (padding, margin, SizedBox)
- ✅ Styles de texte
- ✅ Couleurs
- ✅ Valeurs métier (limites, etc.)
- ✅ Routes nommées

**📖 Voir :** [constants/README.md](constants/README.md)

---

### 📊 `models/`
Contient les **modèles de données** (structure des données).
- ✅ Définit la structure des données
- ✅ Gère la sérialisation/désérialisation (JSON)
- ✅ Contient la validation des données
- ✅ Modèles immutables

**📖 Voir :** [models/README.md](models/README.md)

---

### 🎮 `controllers/`
Contient les **controllers** qui gèrent la logique métier avec Riverpod.
- ✅ Gère la logique métier
- ✅ Gère l'état de l'application (via Riverpod)
- ✅ Ne contient pas d'UI
- ✅ Utilise les services pour les opérations de données
- ✅ Testable facilement

**📖 Voir :** [controllers/README.md](controllers/README.md)

---

### 🔧 `services/`

Contient les **services** qui abstraient les opérations de données.
- ✅ Abstrait les opérations de données
- ✅ Sépare la logique métier (controller) de la gestion des données
- ✅ Facilite les tests (mockable)
- ✅ Facilite l'ajout d'une source de données (API, BDD, etc.)
- ✅ Gestion centralisée des erreurs

**📖 Voir :** [services/README.md](services/README.md)

---
Contient les **services** qui abstraient les opérations de données.
- ✅ Abstrait les opérations de données
- ✅ Sépare la logique métier (controller) de la gestion des données
- ✅ Facilite les tests (mockable)
- ✅ Facilite l'ajout d'une source de données (API, BDD, etc.)
- ✅ Gestion centralisée des erreurs

**📖 Voir :** [services/README.md](services/README.md)

---

### 🛠️ `utils/`
Contient les **utilitaires** (fonctions statiques réutilisables).
- ✅ Fonctions statiques (pas d'instance)
- ✅ Fonctionnalités réutilisables
- ✅ Évite la duplication de code
- ✅ Utilitaires simples et focalisés

**📖 Voir :** [utils/README.md](utils/README.md)

---

### 🧩 `widgets/`
Contient les **widgets réutilisables** (composants UI).
- ✅ Composants UI réutilisables
- ✅ Utilisables dans plusieurs écrans
- ✅ Contient uniquement de l'UI
- ✅ Accessibles (Semantics)

**📖 Voir :** [widgets/README.md](widgets/README.md)

---

### 📱 `screens/`
Contient les **écrans** (pages complètes de l'application).
- ✅ Pages complètes de l'application
- ✅ Utilise les widgets réutilisables
- ✅ Utilise les controllers pour la logique
- ✅ Gère la navigation

**📖 Voir :** [screens/README.md](screens/README.md)

---

## 🔄 Flux de données

### 1. **Modèle** (Models)
Définit la structure des données.

```dart
CompteurModel(valeur: 42)
```

### 2. **Service** (Services)
Abstrait les opérations de données.

```dart
final nouvelleValeur = service.calculerIncrementation(valeur);
final nouveauModele = service.mettreAJourValeur(model, nouvelleValeur);
```

### 3. **Controller** (Controllers)
Gère la logique métier et l'état en utilisant les services.

```dart
controller.incrementer();  // Utilise le service pour modifier le modèle
```

### 4. **Screen** (Screens)
Affiche l'UI et utilise le controller.

```dart
final valeur = ref.watch(compteurValueProvider);
CompteurDisplay(compteur: valeur);
```

### 5. **Widget** (Widgets)
Composants UI réutilisables.

```dart
CompteurDisplay(compteur: valeur)
```

---

## 📖 Documentation

Chaque dossier contient un **README.md** avec :
- ✅ Description du dossier
- ✅ Contenu détaillé
- ✅ Exemples d'utilisation
- ✅ Bonnes pratiques
- ✅ Comment créer de nouveaux éléments

**Consulter les README de chaque dossier pour plus de détails.**

---

## 🎯 Bonnes pratiques

### ✅ Séparation des responsabilités
- **Models** : Structure des données uniquement
- **Services** : Abstraction des opérations de données
- **Controllers** : Logique métier et état (utilise les services)
- **Screens** : UI uniquement
- **Widgets** : Composants UI réutilisables uniquement
- **Utils** : Fonctions utilitaires uniquement

### ✅ Utilisation des constantes
- Ne jamais utiliser de "magic numbers" (30, 50, etc.)
- Toujours utiliser les constantes (`AppSpacing.large`, etc.)
- Centraliser toutes les valeurs dans `constants/`

### ✅ Réutilisabilité
- Créer des widgets réutilisables au lieu de dupliquer le code
- Utiliser les utilitaires pour éviter la duplication
- Partager la logique via les controllers

### ✅ Tests
- Tester les modèles (validation, sérialisation)
- Tester les controllers (logique métier)
- Tester les utilitaires (fonctions statiques)
- Tester les widgets si nécessaire

---

## 🚀 Ajouter un nouveau composant

### 1. Nouvelle constante
→ Créer dans `constants/` avec un nom clair
→ Documenter dans le README du dossier

### 2. Nouveau modèle
→ Créer dans `models/` avec validation
→ Implémenter `toJson()` et `fromJson()`
→ Tester avec des tests unitaires

### 3. Nouveau service
→ Créer dans `services/` avec les méthodes nécessaires
→ Créer le provider Riverpod pour l'injection
→ Utiliser le service dans les controllers
→ Tester avec des tests unitaires

### 4. Nouveau controller
→ Créer dans `controllers/` qui étend `Notifier<T>`
→ Utiliser les services pour les opérations de données
→ Créer le provider Riverpod
→ Tester avec des tests unitaires

### 5. Nouveau widget
→ Créer dans `widgets/` avec `StatelessWidget` ou `ConsumerWidget`
→ Utiliser les constantes (AppSpacing, AppColors, etc.)
→ Ajouter l'accessibilité (Semantics)

### 6. Nouveau screen
→ Créer dans `screens/` qui étend `ConsumerWidget`
→ Utiliser les widgets réutilisables
→ Ajouter la route dans `constants/app_routes.dart`

### 7. Nouvel utilitaire
→ Créer dans `utils/` avec méthodes statiques
→ Documenter chaque méthode
→ Tester avec des tests unitaires

---

## 📚 Ressources

- [Flutter Architecture](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
- [Riverpod Documentation](https://riverpod.dev)
- [Flutter Best Practices](https://docs.flutter.dev/development/best-practices)

---

## ✅ Qualité du code

- ✅ **48 tests unitaires** - 100% passent
- ✅ **0 erreur** de compilation
- ✅ **0 avertissement** de linting
- ✅ **0 magic number** - Tout est dans les constantes
- ✅ **0 duplication** - Code centralisé et réutilisable
- ✅ **Validation complète** des données
- ✅ **Gestion d'erreurs** complète
- ✅ **Accessibilité** complète (Semantics)

**L'application respecte les meilleures pratiques Flutter ! 🎉**
