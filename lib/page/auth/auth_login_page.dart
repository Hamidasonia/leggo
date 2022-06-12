import 'package:flutter/material.dart';
import 'package:leggo/common/constans/icon.dart';
import 'package:leggo/page/auth/auth_register_page.dart';
import 'package:leggo/tool/helper.dart';
import 'package:leggo/tool/hex_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _cEmail;
  late TextEditingController _cPassword;
  late Helper _helper;
  late bool _obscurePassword;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey();
    _formKey = GlobalKey();
    _cEmail = TextEditingController();
    _cPassword = TextEditingController();
    _helper = Helper();
    _obscurePassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: HexColor("F0F4FD"),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: HexColor("#272323"),
              ),
            ),
            const SizedBox(height: 50),
            const Center(
              child: Text(
                "Masuk",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: _cEmail,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "Email atau No. Handphone",
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(color: Colors.grey[500]),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _cPassword,
              obscureText: !_obscurePassword,
              style: const TextStyle(color: Colors.black),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Password field is required';
                }
                if (value.trim().length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[500]),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: HexColor("#272323"),
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Lupa kata sandi?",
              style: TextStyle(
                color: HexColor("#C983DE"),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: MaterialButton(
                onPressed: () {},
                height: 50,
                minWidth: 150,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: HexColor("#433C82"),
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Belum punya akun? ",
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () => _helper.moveToPage(context, page: const RegisterPage()),
                  child: Text(
                    "Daftar",
                    style: TextStyle(
                      color: HexColor("#C983DE"),
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Text(
                  " Atau masuk dengan ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: MaterialButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    minWidth: 150,
                    onPressed: () {},
                    child: Row(
                      children: [
                        Image.asset(kIcGoogle),
                        const SizedBox(width: 5),
                        const Text(
                          "Google",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Material(
                  clipBehavior: Clip.antiAlias,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: MaterialButton(
                    minWidth: 150,
                    onPressed: () {},
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Image.asset(kIcFacebook),
                        const SizedBox(width: 5),
                        const Text(
                          " Facebook",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
