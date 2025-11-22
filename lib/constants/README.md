# 📦 Constants

## 📋 Description

Ce dossier contient toutes les **constantes** de l'application. Les constantes sont des valeurs fixes qui ne changent jamais pendant l'exécution de l'application.

## 🎯 Pourquoi des constantes ?

✅ **Cohérence** : Toutes les valeurs identiques sont centralisées  
✅ **Maintenabilité** : Facile de modifier une valeur partout en changeant un seul endroit  
✅ **Lisibilité** : `AppSpacing.large` est plus lisible que `50.0`  
✅ **Réduction des erreurs** : Pas de "magic numbers" dispersés dans le code

## 📁 Contenu

### `app_spacing.dart`
Espacements utilisés dans toute l'application (padding, margin, SizedBox).

**Usage :**
```dart
import '../constants/app_spacing.dart';

const SizedBox(height: AppSpacing.large);  // Au lieu de 50.0
const Padding(padding: EdgeInsets.all(AppSpacing.medium));  // Au lieu de 20.0
```

**Valeurs disponibles :**
- `AppSpacing.xs`, `sm`, `small` - Espacements petits (4, 8, 12)
- `AppSpacing.md`, `medium`, `lg` - Espacements moyens (16, 20, 24)
- `AppSpacing.xl`, `xxl`, `large` - Espacements grands (30, 40, 50)
- `AppSpacing.huge`, `massive` - Espacements très grands (60, 80)

---

### `app_text_styles.dart`
Styles de texte réutilisables dans toute l'application.

**Usage :**
```dart
import '../constants/app_text_styles.dart';

Text('Mon texte', style: AppTextStyles.titleMedium);
Text('Autre texte', style: AppTextStyles.bodySmall);
```

**Styles disponibles :**
- `AppTextStyles.bodySmall` - Texte petit (12px, gris)
- `AppTextStyles.bodyMedium` - Texte moyen (16px)
- `AppTextStyles.titleMedium` - Titre moyen (20px, léger)
- `AppTextStyles.headlineLarge` - Titre très grand (80px, bold, monospace)
- `AppTextStyles.italicGrey` - Texte italique gris

---

### `app_colors.dart`
Couleurs utilisées dans toute l'application.

**Usage :**
```dart
import '../constants/app_colors.dart';

FloatingActionButton(
  backgroundColor: AppColors.buttonIncrement,  // Vert
);
Text('Compteur', style: TextStyle(color: AppColors.compteurPositif));
```

**Couleurs disponibles :**
- `AppColors.compteurZero` - Gris (valeur = 0)
- `AppColors.compteurPositif` - Vert (valeur > 0)
- `AppColors.compteurNegatif` - Rouge (valeur < 0)
- `AppColors.buttonIncrement` - Vert pour bouton +
- `AppColors.buttonDecrement` - Rouge pour bouton -
- `AppColors.buttonReset` - Gris pour bouton reset
- `AppColors.primary` - Couleur primaire (deepPurple)

---

### `app_values.dart`
Valeurs métier et limites de l'application.

**Usage :**
```dart
import '../constants/app_values.dart';

if (valeur > AppValues.compteurMax) {
  // Gérer l'erreur
}
Text('Version: ${AppValues.appVersion}');
```

**Valeurs disponibles :**
- `AppValues.compteurMin` - Limite minimale du compteur (-1000)
- `AppValues.compteurMax` - Limite maximale du compteur (1000)
- `AppValues.compteurValeurInitiale` - Valeur initiale (0)
- `AppValues.compteurValeurSeuil` - Seuil pour messages spéciaux (10)
- `AppValues.appTitle` - Titre de l'application
- `AppValues.appVersion` - Version de l'application

---

### `app_routes.dart`
Routes nommées de l'application pour la navigation.

**Usage :**
```dart
import '../constants/app_routes.dart';

// Navigation avec route nommée
Navigator.of(context).pushNamed(AppRoutes.aPropos);
```

**Routes disponibles :**
- `AppRoutes.home` - Route vers l'écran d'accueil (`/`)
- `AppRoutes.aPropos` - Route vers l'écran "À propos" (`/a-propos`)
- `AppRoutes.homeName` - Nom de la route home (`'home'`)
- `AppRoutes.aProposName` - Nom de la route "À propos" (`'a-propos'`)

---

## 📚 Bonnes pratiques

### ✅ À FAIRE
- Utiliser les constantes au lieu de valeurs en dur
- Importer seulement les constantes nécessaires
- Créer de nouvelles constantes si besoin de valeurs réutilisables

### ❌ À ÉVITER
- Utiliser des "magic numbers" (30, 50, etc.) dans le code
- Dupliquer les mêmes valeurs dans plusieurs fichiers
- Modifier les constantes sans vérifier leur impact

---

## 🔄 Ajouter une nouvelle constante

1. **Identifier le fichier approprié** (ou créer un nouveau si nécessaire)
2. **Ajouter la constante** avec un nom clair et descriptif
3. **Documenter** son usage dans un commentaire
4. **Utiliser** la constante dans tout le code concerné

**Exemple :**
```dart
// Dans app_values.dart
class AppValues {
  AppValues._();
  
  // Nouvelle constante
  static const int nouvelleValeur = 42;
}
```

---

## 📖 Ressources

- [Dart Style Guide - Constants](https://dart.dev/guides/language/effective-dart/style)
- [Flutter Best Practices - Constants](https://docs.flutter.dev/development/ui/widgets)
