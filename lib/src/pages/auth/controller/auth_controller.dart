import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utilServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndPrecedToBase();
      },
      error: (msg) {
        signOut();
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );

    isLoading.value = false;

    if (result) {
      //msg
      utilServices.showToast(message: 'A senha foi atualizada');
      //logout
    } else {
      utilServices.showToast(
        message: 'A senha está incorreta',
        isError: true,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> signOut() async {
    //Zerar o user
    user = UserModel();

    //Remover o token localmente
    await utilServices.removeLocalData(key: StorageKeys.token);

    //Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndPrecedToBase() {
    //salvar o token
    utilServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    //Ir para a tela base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      saveTokenAndPrecedToBase();
    }, error: (msg) {
      utilServices.showToast(
        message: msg,
        isError: true,
      );
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result = await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        saveTokenAndPrecedToBase();
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
