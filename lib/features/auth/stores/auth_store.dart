import 'package:ai_expense_tracker/core/services/firebase_services.dart';
import 'package:mobx/mobx.dart';


part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseService _firebaseService = FirebaseService();

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @action
  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      await _firebaseService.signIn(email, password);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> register(String email, String password) async {
    try {
      isLoading = true;
      error = null;
      await _firebaseService.register(email, password);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
