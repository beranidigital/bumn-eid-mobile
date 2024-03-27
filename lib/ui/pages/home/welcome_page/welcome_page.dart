import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/core/utils/utils.dart';
import 'package:bumn_eid/ui/components/button.dart';
import 'package:bumn_eid/ui/components/text_field.dart';
import 'package:bumn_eid/ui/pages/home/qrcode_scanner/qrcode_scanner_page.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/bloc/welcome_page_bloc.dart';
import 'package:bumn_eid/ui/pages/home/welcome_page/di/welcome_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WelcomePage extends StatefulWidget with InjectableWidget {
  final WelcomePageGraph _graph;

  //injected
  ColorPalette colorPalette;

  //injected
  Utils utils;

  //injected
  WelcomePageBloc bloc;

  WelcomePage([graph]) : this._graph = graph ?? WelcomePageGraph() {
    setup();
  }

  @override
  WelcomePageGraph graph() => _graph;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isPasswordVisible = false;

  Color colorButton = Color(0XFF1FA5CA);

  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  Widget titleText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        Strings.getString("WelcomePage.Title"),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: widget.colorPalette.white,
            fontFamily: 'College'),
      ),
    );
  }

  Widget mainContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 120.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
            child: Image(
              image: AssetImage("res/images/logo.png"),
            ),
          ),
          titleText(context),
          formWidget(context)
        ],
      ),
    );
  }

  Widget emailField(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.emailStream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: EidTextField(
            onChanged: widget.bloc.inputEmail,
            labelText: Strings.getString("WelcomePage.EmailLabel"),
            hintText: Strings.getString("WelcomePage.EmailHint"),
            errorText: snapshot.error,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(
              Icons.people_outline,
              size: 16.0,
              color: widget.colorPalette.primary,
            ),
          ),
        );
      },
    );
  }

  Widget passwordField(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.passwordStream,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: EidTextField(
            onChanged: widget.bloc.inputPassword,
            errorText: snapshot.error,
            labelText: Strings.getString("WelcomePage.PasswordLabel"),
            hintText: Strings.getString("WelcomePage.PasswordHint"),
            obscureText: !isPasswordVisible,
            prefixIcon: Icon(
              Icons.lock,
              size: 16.0,
              color: widget.colorPalette.primary,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                size: 24.0,
                color: widget.colorPalette.primary,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget textFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          emailField(context),
          passwordField(context),
        ],
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.submitEnabled,
      builder: (context, snapshot) {
        bool enabled = snapshot.data ?? false;
        return Button(
          backgroundColor: widget.colorPalette.primary,
          onTap: !enabled ? null : () => widget.bloc.submitLogin(),
          text: Strings.getString("WelcomePage.LoginButtonText"),
          padding: EdgeInsets.symmetric(horizontal: 84.0, vertical: 16.0),
        );
      },
    );
  }

  void loginWithQR(BuildContext context) async {
    final res = await getQRCode(context: context);
    print(res);

    if (res != null && res.code.isNotEmpty) {
      widget.bloc.actionMapper.submitLoginQR(
        code: res.code,
      );
    }
  }

  Widget formWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: widget.colorPalette.white,
            borderRadius: BorderRadius.circular(16.0)),
        padding: EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            textFields(context),
            SizedBox(
              height: 16.0,
            ),
            InkWell(
              onTap: () => loginWithQR(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 14.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'login dengan QR',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: loginButton(context),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF134A6E),
      body: SafeArea(
        child:
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   decoration: BoxDecoration(
            //     color: widget.colorPalette.primary,
            //     image: DecorationImage(
            //         image: AssetImage(
            //           "res/images/home.png",
            //         ),
            //         fit: BoxFit.fill),
            //   ),
            //   child: mainContent(context),
            // ),
            ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 340,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 340,
                            decoration: BoxDecoration(
                              color: widget.colorPalette.primary,
                              image: DecorationImage(
                                image: AssetImage(
                                  "res/images/home.png",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        ClipPath(
                          clipper: MyClipper(),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            width: MediaQuery.of(context).size.width,
                            height: 340,
                            color: Color(0xFF134A6E).withOpacity(0.85),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  width: 200,
                                  image: AssetImage(
                                    "res/images/logo_bumn_terbaru.png",
                                  ),
                                ),
                                SizedBox(height: 30),
                                Text(
                                  "Executive Information Dashboard",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Kementerian BUMN Republik Indonesia",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(0, -15),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: widget.bloc.emailStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  onChanged: widget.bloc.inputEmail,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    labelText: "Email",
                                    hintText: "Email Anda",
                                    labelStyle: TextStyle(color: colorButton),
                                    errorText: snapshot.error,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorButton, width: 1.2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorButton, width: 1.5),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: colorButton,
                                      // color: Colors.blue,
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                );
                              },
                            ),
                            SizedBox(height: 15),
                            StreamBuilder(
                              stream: widget.bloc.passwordStream,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  obscureText: !isPasswordVisible,
                                  onChanged: widget.bloc.inputPassword,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorButton, width: 1.2),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colorButton, width: 1.5),
                                    ),
                                    errorText: snapshot.error,
                                    labelText: "Password",
                                    labelStyle: TextStyle(color: colorButton),
                                    hintText: "Password Anda",
                                    prefixIcon: Icon(
                                      Icons.vpn_key_rounded,
                                      color: colorButton,
                                      // color: Colors.blue,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 24.0,
                                        color: widget.colorPalette.primary,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 50),
                            StreamBuilder(
                              stream: widget.bloc.submitEnabled,
                              builder: (context, snapshot) {
                                bool enabled = snapshot.data ?? false;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color:
                                        (enabled) ? colorButton : Colors.grey,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        offset: Offset(0, 3),
                                        blurRadius: 5,
                                        spreadRadius: 1.5,
                                      ),
                                    ],
                                  ),
                                  child: MaterialButton(
                                    splashColor: Colors.white.withOpacity(0.0),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    onPressed: () {
                                      !enabled
                                          ? null
                                          : widget.bloc.submitLogin();
                                    },
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: colorButton,
                                  width: 2,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                splashColor: Colors.white.withOpacity(0.0),
                                onPressed: () {
                                  loginWithQR(context);
                                },
                                child: Text(
                                  "Masuk Dengan QR Code",
                                  style: TextStyle(
                                    color: colorButton,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.lineTo(size.width / 2, size.height);
    path.lineTo(0, ((8.3 / 10) * size.height));
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, ((8.3 / 10) * size.height));
    path.lineTo(size.width, 0);
    path.close();
    // path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
