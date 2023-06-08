import 'package:firebase_auth/firebase_auth.dart';

void handleFirebaseError(dynamic error) {
  String errorMessage = '';
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        errorMessage = 'Invalid email address.';
        break;
      case 'user-disabled':
        errorMessage = 'User account has been disabled.';
        break;
      case 'user-not-found':
        errorMessage = 'User not found.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password.';
        break;
      case 'email-already-in-use':
        errorMessage = 'Email is already in use';
        break;
      case 'weak-password':
        errorMessage = 'Password is too weak';
        break;
      case 'requires-recent-login':
        errorMessage = 'Session Expired. Login Again';
        break;
      default:
        errorMessage = 'An error occurred.';
        break;
    }
  } else if (error is FirebaseException) {
    switch (error.code) {
      case 'too-many-requests':
        errorMessage = 'Too many requests, please try again later';
        break;
      default:
        errorMessage = error.message ?? errorMessage;
        break;
    }
  }
  // customSnackBar("Error", errorMessage);
}
