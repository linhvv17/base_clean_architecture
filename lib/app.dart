import 'package:base_clean_architecture/core/core.dart';
import 'package:base_clean_architecture/dependencies_injection.dart';
import 'package:base_clean_architecture/features/features.dart';
import 'package:base_clean_architecture/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MaterialApp(
      localizationsDelegates: const [
        Strings.delegate,
        // GlobalMaterialLocalizatio
        // s.delegate,
      ],
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<AuthCubit>()),
          ],
          child: OKToast(
            child: ScreenUtilInit(
                designSize: const Size(375, 667),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context, __) {
                  return BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return LoginPage();
                    },

                  );
                }),
          )),
    );
  }
}
