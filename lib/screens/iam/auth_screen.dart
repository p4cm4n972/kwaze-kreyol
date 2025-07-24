import 'package:flutter/material.dart';
import 'package:kwaze_kreyol/main.dart';
import 'package:kwaze_kreyol/widgets/creole_background.dart';
import '../../services/iam/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String pseudo = '';
  String email = '';
  String password = '';
  final AuthService _authService = AuthService();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    String? error;
    if (isLogin) {
      error = await _authService.login(email, password);
      if (!mounted) return;
      if (error == null) {
        _showWelcomeDialog(); // va vers HomeScreen
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    } else {
      error = await _authService.register(pseudo, email, password);
      if (!mounted) return;

      if (error == null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('📧 Confirme ton e-mail'),
            content: Text("Un lien de confirmation a été envoyé à $email."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() => isLogin = true); // retour à formulaire login
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
      }
    }
  }

  void _showWelcomeDialog() async {
    final decodedPseudo = await _authService.getPseudoFromToken();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('🎉 Bienvenue !'),
        content: Text('Bon retour parmi nous, ${decodedPseudo ?? pseudo} !'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
            child: const Text("Continuer"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CreoleBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLogin ? 'Connexion' : 'Créer un compte',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) => value != null && value.length >= 3
                            ? null
                            : 'Email requis',
                        onSaved: (value) => email = value!,
                      ),
                      const SizedBox(height: 12),
                      if (!isLogin)
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              value != null &&
                                  value.isNotEmpty &&
                                  !value.contains('@')
                              ? 'Email invalide'
                              : null,
                          onSaved: (value) => email = value!,
                        ),
                      if (!isLogin) const SizedBox(height: 12),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Mot de passe',
                        ),
                        obscureText: true,
                        validator: (value) => value != null && value.length >= 6
                            ? null
                            : 'Minimum 6 caractères',
                        onSaved: (value) => password = value!,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          isLogin ? 'Se connecter' : 'Créer un compte',
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => isLogin = !isLogin),
                        child: Text(
                          isLogin
                              ? "Pas encore de compte ? S'inscrire"
                              : 'Déjà inscrit ? Se connecter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
