<<<<<<< HEAD
import 'package:ai_expense_tracker/features/auth/widgets/auth_button.dart';
import 'package:ai_expense_tracker/features/auth/widgets/auth_header.dart';
import 'package:ai_expense_tracker/features/auth/widgets/auth_text_field.dart';
import 'package:ai_expense_tracker/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _obscurePassword = true;

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
        }, SetOptions(merge: true));

        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getErrorMessage(e)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case "email-already-in-use":
        return "An account already exists with this email.";

      case "weak-password":
        return "Password must be at least 6 characters.";

      case "invalid-email":
        return "Please enter a valid email address.";

      default:
        return e.message ?? "Registration failed.";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  48,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const SizedBox(height: 20),

                const AuthHeader(
                  title: "Create Account",
                  subtitle:
                      "Join FinMate AI and start managing your finances smarter.",
                ),

                const SizedBox(height: 40),

                Card(
                  elevation: 3,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Form(
                      key: _formKey,

                      child: Column(
                        children: [

                          AuthTextField(
                            controller: _nameController,
                            hint: "Full Name",
                            icon: Icons.person_outline,

                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter your full name";
                              }

                              if (value.trim().length < 2) {
                                return "Name is too short";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          AuthTextField(
                            controller: _emailController,
                            hint: "Email Address",
                            icon: Icons.email_outlined,
                            keyboardType:
                                TextInputType.emailAddress,

                            validator: (value) {

                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter your email";
                              }

                              if (!RegExp(
                                r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value.trim())) {
                                return "Enter a valid email";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          AuthTextField(
                            controller: _passwordController,
                            hint: "Password",
                            icon: Icons.lock_outline,
                            obscureText: _obscurePassword,

                            validator: (value) {

                              if (value == null ||
                                  value.isEmpty) {
                                return "Please enter a password";
                              }

                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }

                              return null;
                            },

                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 30),

                          AuthButton(
                            text: "Create Account",
                            loading: _loading,
                            onPressed: _register,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                        ),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Powered by FinMate AI",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
=======
import 'package:ai_expense_tracker/features/auth/widgets/auth_button.dart';
import 'package:ai_expense_tracker/features/auth/widgets/auth_header.dart';
import 'package:ai_expense_tracker/features/auth/widgets/auth_text_field.dart';
import 'package:ai_expense_tracker/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _loading = false;
  bool _obscurePassword = true;

  Future<void> _register() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        final uid = userCredential.user!.uid;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set({
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
        }, SetOptions(merge: true));

        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getErrorMessage(e)),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case "email-already-in-use":
        return "An account already exists with this email.";

      case "weak-password":
        return "Password must be at least 6 characters.";

      case "invalid-email":
        return "Please enter a valid email address.";

      default:
        return e.message ?? "Registration failed.";
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  48,
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const SizedBox(height: 20),

                const AuthHeader(
                  title: "Create Account",
                  subtitle:
                      "Join FinMate AI and start managing your finances smarter.",
                ),

                const SizedBox(height: 40),

                Card(
                  elevation: 3,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(24),

                    child: Form(
                      key: _formKey,

                      child: Column(
                        children: [

                          AuthTextField(
                            controller: _nameController,
                            hint: "Full Name",
                            icon: Icons.person_outline,

                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter your full name";
                              }

                              if (value.trim().length < 2) {
                                return "Name is too short";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          AuthTextField(
                            controller: _emailController,
                            hint: "Email Address",
                            icon: Icons.email_outlined,
                            keyboardType:
                                TextInputType.emailAddress,

                            validator: (value) {

                              if (value == null ||
                                  value.trim().isEmpty) {
                                return "Please enter your email";
                              }

                              if (!RegExp(
                                r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value.trim())) {
                                return "Enter a valid email";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 20),

                          AuthTextField(
                            controller: _passwordController,
                            hint: "Password",
                            icon: Icons.lock_outline,
                            obscureText: _obscurePassword,

                            validator: (value) {

                              if (value == null ||
                                  value.isEmpty) {
                                return "Please enter a password";
                              }

                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }

                              return null;
                            },

                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword =
                                      !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 30),

                          AuthButton(
                            text: "Create Account",
                            loading: _loading,
                            onPressed: _register,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.login,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        const TextSpan(
                          text: "Already have an account? ",
                        ),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Powered by FinMate AI",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}