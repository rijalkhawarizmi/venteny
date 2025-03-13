import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:venteny/common/common_widget/alert_error.dart';
import 'package:venteny/common/common_widget/alert_loading.dart';
import 'package:venteny/core/utils/validation.dart';
import 'package:venteny/src/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:venteny/src/home/presentation/pages/home_page.dart';
import '../../../../common/common_widget/custom_button.dart';
import '../../../../common/common_widget/custom_textfield.dart';
import '../../../../core/config/color_app.dart';

class LoginPage extends StatelessWidget {
  static const String route="login-page";
  final TextEditingController _email = TextEditingController(text: "eve.holt@reqres.in");
  final TextEditingController _password = TextEditingController(text: "cityslicka");

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
        backgroundColor: ColorApp.white,
          appBar: AppBar(
            title: Text('Login'),
          ),
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFormField(
                  hintText: "Email",
                  hintStyle: TextStyle(
                      color: ColorApp.slate400,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  controller: _email,
                   validator: (v){
                     return Validation.validateEmail(v);
                   }
                      
                ),
                 Padding(
                   padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                   child: CustomTextFormField(
                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: ColorApp.slate700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    controller: _password,
                    validator: (v){
                     return Validation.validatePassword(v);
                    },
                                 ),
                 ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if(state.status==StatusLogin.loading){
                      AlertLoading.show(context,"Please wait");
                    }else if(state.status==StatusLogin.success){
                      AlertLoading.hide(context);
                      context.goNamed(HomePage.route);
                    }else if(state.status==StatusLogin.failure){
                      AlertError.show(context, "Error");
                      AlertLoading.hide(context);
                    }
                  },
                  child: CustomButton(
                    backgroundColor: ColorApp.brand500,
                    title: "Login",
                    fontSize: 17,
                    colorTitle: ColorApp.white,
                    onPressed: () async {
                      if(_key.currentState?.validate() ?? false){
                        _key.currentState!.save();
                        context.read<LoginBloc>().add(
                          LoginEvent(email: _email.text, password: _password.text));
                      }
                      
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
