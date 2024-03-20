import 'package:clinic_core/clinic_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinicas_self_service/src/modules/auth/login/login_controller.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final controller = Injector.get<LoginController>();

  @override
  void initState() {
    messageListener(controller);
    effect(() {
      if (controller.logged) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            constraints: BoxConstraints(
              minHeight: sizeOf.height,
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_login.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(40),
                constraints: BoxConstraints(maxWidth: sizeOf.width * 0.8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Login',
                        style: LabClinicasTheme.titleStyle,
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: emailEC,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                      ),
                      const SizedBox(height: 24),
                      Watch((_) {
                        return TextFormField(
                          controller: passwordEC,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.passwordTogle();
                              },
                              icon: controller.obscurePassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                          ),
                          obscureText: controller.obscurePassword,
                          validator: Validatorless.required('Campo obrigatório'),
                        );
                      }),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: sizeOf.width * 0.8,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            final valid = formKey.currentState?.validate() ?? false;

                            if (valid) {
                              controller.login(emailEC.text, passwordEC.text);
                            }
                          },
                          child: const Text('Entrar'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
