import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venteny/common/bloc/theme/theme_bloc.dart';
import 'package:venteny/core/routes/routes.dart';
import 'package:venteny/core/utils/notification_api.dart';
import 'package:venteny/src/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/create_task/create_task_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/delete_task/delete_task_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/get_taks/get_tasks_bloc.dart';
import 'package:venteny/src/home/presentation/bloc/task/search/search_bloc.dart';
import 'common/bloc/date/date_bloc.dart';
import 'common/bloc/status/status_bloc.dart';
import 'common/common_widget/custom_snackbar.dart';
import 'core/config/app_connectivity.dart';
import 'core/services/injection_container.dart';
import 'src/home/presentation/bloc/task/update_task/update_task_bloc.dart';
import 'package:timezone/data/latest_all.dart' as tz;
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MyApp());
  NotificationApi.init();
  
  AppConnectivity.checkConnectivity();
  AppConnectivity.dispose();

  await init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<GetTasksBloc>()),
        BlocProvider(create: (context) => sl<CreateTaskBloc>()),
        BlocProvider(create: (context) => sl<DeleteTaskBloc>()),
        BlocProvider(create: (context) => sl<UpdateTaskBloc>()),
        BlocProvider(create: (context) => sl<SearchBloc>()),
        BlocProvider(create: (context) => sl<ThemeBloc>()),
        BlocProvider(create: (context) => sl<DateBloc>()),
        BlocProvider(create: (context) => sl<StatusBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            scaffoldMessengerKey: scaffoldMessengerKey,
            routerConfig: routers,
            theme: state.isModeDark ? ThemeData.dark() : ThemeData.light(),
          );
        },
      ),
    );
  }
}
