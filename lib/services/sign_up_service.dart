import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saveon_frontend/models/common/saveon_button.dart';
import 'package:saveon_frontend/models/common/saveon_section.dart';
import 'package:saveon_frontend/models/common/saveon_spacer.dart';
import 'package:saveon_frontend/models/common/saveon_textbutton.dart';

import '../models/common/clickable_svg_logo.dart';
import '../models/common/coming_soon_alert.dart';
import '../models/common/saveon_textbutton_small.dart';
import '../widgets/login_flow/login_page.dart';

class SaveOnSignupPage extends StatefulWidget {
  const SaveOnSignupPage({super.key});

  @override
  State<SaveOnSignupPage> createState() => _SaveOnSignupPage();
}

class _SaveOnSignupPage extends State<SaveOnSignupPage> {
  final _formKey = GlobalKey<FormState>(); //form key

  //form controllers
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _dateOfBirthCtrl = TextEditingController();
  DateTime? _selectedDateOfBirth;
  bool _hidePassword = true;

  //other
  bool _rememberMe = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _dateOfBirthCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),

                //Content
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Welcome titles
                    Column(
                      children: [
                        Text(
                          'Get Started!',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Track your finances. Share your expenses.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    //Registration form
                    SaveOnSection(
                      SaveOnSectionContent: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //form-name
                              TextFormField(
                                controller: _nameCtrl,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  prefixIcon: Icon(Icons.person_outline),
                                  hintText: "Enter your name",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'Please enter your name';
                                  if (value.trim().length < 2) {
                                    return 'Name must be at least 2 characters';
                                  }
                                  return null;
                                },
                              ),
                              SaveOnSpacer(),

                              //form-surname
                              TextFormField(
                                controller: _surnameCtrl,
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Surname',
                                  prefixIcon: Icon(Icons.badge_outlined),
                                  hintText: "Enter your surname",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty)
                                    return 'Please enter your surname';
                                  if (value.trim().length < 2) {
                                    return 'Surname must be at least 2 characters';
                                  }
                                  return null;
                                },
                              ),
                              SaveOnSpacer(),

                              //form-email
                              TextFormField(
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintText: "Enter your email",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  final emailRegex = RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+$',
                                  );
                                  if (!emailRegex.hasMatch(value.trim())) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              SaveOnSpacer(),

                              //form-date of birth
                              TextFormField(
                                controller: _dateOfBirthCtrl,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'Date of birth (optional)',
                                  prefixIcon: Icon(Icons.calendar_today_outlined),
                                  hintText: "Select your date of birth",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty == null) {
                                    return null;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  // Show date picker when field is tapped
                                  FocusScope.of(context).requestFocus(FocusNode()); // Remove keyboard focus

                                  final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: _selectedDateOfBirth ?? DateTime.now().subtract(const Duration(days: 365 * 18)), // Default to 18 years ago
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    helpText: 'Select date of birth',
                                  );

                                  if (picked != null && picked != _selectedDateOfBirth) {
                                    setState(() {
                                      _selectedDateOfBirth = picked;
                                      _dateOfBirthCtrl.text = DateFormat('dd.MM.yyyy').format(picked);
                                    });
                                  }
                                },
                              ),
                              SaveOnSpacer(),

                              //form-password
                              TextFormField(
                                controller: _passwordCtrl,
                                obscureText: _hidePassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  hintText: "Enter safe password",
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _hidePassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                    onPressed:
                                        () => setState(
                                          () => _hidePassword = !_hidePassword,
                                        ),
                                  ),
                                ),
                                validator:
                                    (value) =>
                                        value == null || value.length < 6
                                            ? 'Password must be at least 6 characters'
                                            : null,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    //remember me and forget password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //checkbox for remembering me
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                "Remember me",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),

                          //forget password (DEVELOP!)
                          SaveOnTextButtonSmall(
                            onPressed: () => showComingSoonDialog(context),
                            buttonLabel: "Forget password?",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    //sign up button DEVELOP!
                    Align(
                      child: Container(
                        child: SaveOnButton(
                          buttonText: "Sign up",
                          onPressed: () {},
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    //sign up with
                    Column(
                      children: [
                        //text line with text sign up with
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Color(0xFFC0C0C0),
                                height: 0.2,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Sign up with",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                color: Color(0xFFC0C0C0),
                                height: 0.2,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),

                        //clickable logoes as way to sign up
                        Row(
                          children: [
                            Expanded(flex: 2, child: SizedBox()),
                            ClickableSvgLogo(
                              SvgPath: "lib/assets/logos/google_logo_30px.svg",
                              onTap: () => showComingSoonDialog(context),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            ClickableSvgLogo(
                              SvgPath: "lib/assets/logos/apple_logo_30px.svg",
                              onTap: () => showComingSoonDialog(context),
                            ),
                            Expanded(flex: 1, child: SizedBox()),
                            ClickableSvgLogo(
                              SvgPath:
                                  "lib/assets/logos/facebook_logo_30px.svg",
                              onTap: () => showComingSoonDialog(context),
                            ),
                            Expanded(flex: 2, child: SizedBox()),
                          ],
                        ),
                        const SizedBox(height: 18),

                        //sign in if have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(width: 5),
                            SaveOnTextButtonSmall(
                              buttonLabel: "Sign in",
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).push(MaterialPageRoute(builder: (_) => const SaveonLoginPage()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
