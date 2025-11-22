import 'package:flutter/material.dart';
import 'app.dart';

// ==========================================
// POINT D'ENTRÉE : main()
// ==========================================
// 
// Ce fichier est très simple : il lance juste l'application !
// Tout le reste est organisé dans d'autres fichiers :
//
// 📁 Structure du projet :
//   lib/
//   ├── main.dart              ← Vous êtes ici ! Point d'entrée
//   ├── app.dart              ← Configuration de l'application
//   ├── screens/               ← Écrans de l'application
//   │   └── ecran_accueil.dart ← Page d'accueil
//   └── widgets/               ← Widgets réutilisables
//       ├── compteur_display.dart    ← Affichage du compteur
//       ├── boutons_controle.dart    ← Boutons de contrôle
//       └── message_aide.dart        ← Message d'aide
//
// ==========================================
// POURQUOI SÉPARER EN COMPOSANTS ?
// ==========================================
//
// ✅ Code plus lisible : chaque fichier a un rôle clair
// ✅ Code réutilisable : on peut réutiliser les widgets partout
// ✅ Plus facile à maintenir : modifier un widget ne change pas le reste
// ✅ Plus facile à tester : on teste chaque composant séparément
// ✅ Plus professionnel : c'est comme ça qu'on fait dans les vrais projets
//
// ==========================================

void main() {
  // main() est le point d'entrée de votre application
  // runApp() lance l'application avec le widget racine
  // 
  // On importe MonApplicationFlutter depuis app.dart
  // au lieu de tout mettre dans main.dart
  runApp(const MonApplicationFlutter());
}