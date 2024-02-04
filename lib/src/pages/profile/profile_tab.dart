import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/input_field_widget.dart';
import 'package:greengrocer/src/services/validators.dart';
import 'package:greengrocer/src/config/app_data.dart' as appData;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Perfil do usuário',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          InputFieldWidget(
            icon: const Icon(Icons.email),
            label: 'E-mail',
            initialValue: authController.user.email,
            readOnly: true,
          ),
          InputFieldWidget(
            icon: const Icon(Icons.person),
            label: 'Nome',
            initialValue: authController.user.name,
            readOnly: true,
          ),
          InputFieldWidget(
            icon: const Icon(Icons.phone),
            label: 'Celular',
            initialValue: authController.user.phone,
            readOnly: true,
          ),
          InputFieldWidget(
            icon: const Icon(Icons.file_copy),
            label: 'CPF',
            isSecret: true,
            initialValue: authController.user.cpf,
            readOnly: true,
          ),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => _updatePassword(),
              child: const Text('Atualizar senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _updatePassword() {
    final passwordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final curentPasswordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (bc) => Dialog(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualizar senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InputFieldWidget(
                      controller: curentPasswordController,
                      isSecret: true,
                      icon: Icon(Icons.lock),
                      label: 'Senha atual',
                      validator: passwordValidador,
                    ),
                    InputFieldWidget(
                      controller: newPasswordController,
                      isSecret: true,
                      icon: Icon(Icons.lock_outline),
                      label: 'Nova senha',
                      validator: passwordValidador,
                    ),
                    InputFieldWidget(
                      isSecret: true,
                      icon: Icon(Icons.lock_outline),
                      label: 'Confirmar nova senha',
                      validator: (password) {
                        final result = passwordValidador(password);

                        if (result != null) {
                          return result;
                        }

                        if (password != passwordController.text) {
                          return 'As senhas não são equivalentes';
                        }

                        return null;
                      },
                    ),

                    //botão confirmação
                    SizedBox(
                      height: 45,
                      child: Obx(() => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.changePassword(
                                        currentPassword: newPasswordController.text,
                                        newPassword: curentPasswordController.text,
                                      );
                                    }
                                    ;
                                  },
                            child: authController.isLoading.value ? CircularProgressIndicator() : Text('Atualizar'),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
