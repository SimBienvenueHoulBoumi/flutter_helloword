// ==========================================
// SERVICE : Gestionnaire d'erreurs global
// ==========================================
// 
// Ce service centralise la gestion des erreurs de l'application.
// 
// ✅ AVANTAGES :
// - Gestion centralisée des erreurs
// - Messages d'erreur cohérents
// - Facilite le logging et le monitoring
// - Facilite l'affichage des erreurs à l'utilisateur
//
// ==========================================

import 'package:flutter/material.dart';
import '../models/compteur_model.dart';

/// Types d'erreurs dans l'application
enum TypeErreur {
  validation,
  reseau,
  stockage,
  inconnu,
}

/// Représentation standardisée d'une erreur
class ErreurApplication {
  final TypeErreur type;
  final String message;
  final Object? erreurOriginale;
  final StackTrace? stackTrace;

  ErreurApplication({
    required this.type,
    required this.message,
    this.erreurOriginale,
    this.stackTrace,
  });

  /// Crée une erreur à partir d'une exception
  factory ErreurApplication.fromException(Object exception) {
    if (exception is CompteurModelException) {
      return ErreurApplication(
        type: TypeErreur.validation,
        message: exception.message,
        erreurOriginale: exception,
      );
    }

    // Erreur réseau (exemple pour l'avenir)
    if (exception.toString().contains('SocketException') ||
        exception.toString().contains('HttpException')) {
      return ErreurApplication(
        type: TypeErreur.reseau,
        message: 'Erreur de connexion. Vérifiez votre connexion internet.',
        erreurOriginale: exception,
      );
    }

    // Erreur par défaut
    return ErreurApplication(
      type: TypeErreur.inconnu,
      message: 'Une erreur inattendue s\'est produite.',
      erreurOriginale: exception,
    );
  }

  @override
  String toString() => message;
}

/// Service global pour gérer les erreurs
class ErrorHandler {
  ErrorHandler._(); // Constructeur privé pour empêcher l'instanciation

  /// Affiche une erreur à l'utilisateur via un Snackbar
  static void afficherErreur(BuildContext context, ErreurApplication erreur) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(erreur.message),
        backgroundColor: _getCouleurErreur(erreur.type),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Affiche une erreur via une boîte de dialogue
  static Future<void> afficherErreurDialog(
    BuildContext context,
    ErreurApplication erreur,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_getTitreErreur(erreur.type)),
        content: Text(erreur.message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Log une erreur (pourrait être étendu pour envoyer à un service de logging)
  static void loggerErreur(ErreurApplication erreur) {
    // Ici, on pourrait envoyer à un service de logging (Sentry, Firebase, etc.)
    debugPrint('🔴 Erreur [${erreur.type}]: ${erreur.message}');
    if (erreur.stackTrace != null) {
      debugPrint('Stack trace: ${erreur.stackTrace}');
    }
  }

  /// Gère une exception et affiche un message à l'utilisateur
  static void gererErreur(
    BuildContext context,
    Object exception, {
    bool afficherDialog = false,
  }) {
    final erreur = ErreurApplication.fromException(exception);
    loggerErreur(erreur);
    
    if (afficherDialog) {
      afficherErreurDialog(context, erreur);
    } else {
      afficherErreur(context, erreur);
    }
  }

  /// Récupère la couleur selon le type d'erreur
  static Color _getCouleurErreur(TypeErreur type) {
    switch (type) {
      case TypeErreur.validation:
        return Colors.orange;
      case TypeErreur.reseau:
        return Colors.red;
      case TypeErreur.stockage:
        return Colors.red.shade700;
      case TypeErreur.inconnu:
        return Colors.grey;
    }
  }

  /// Récupère le titre selon le type d'erreur
  static String _getTitreErreur(TypeErreur type) {
    switch (type) {
      case TypeErreur.validation:
        return 'Erreur de validation';
      case TypeErreur.reseau:
        return 'Erreur de connexion';
      case TypeErreur.stockage:
        return 'Erreur de stockage';
      case TypeErreur.inconnu:
        return 'Erreur';
    }
  }
}
