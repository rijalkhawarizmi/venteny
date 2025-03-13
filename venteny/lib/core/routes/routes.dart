import 'package:go_router/go_router.dart';
import 'package:venteny/src/home/domain/entities/home_entity.dart';
import 'package:venteny/src/home/presentation/pages/search_page.dart';

import '../../src/authentication/presentation/pages/login_page.dart';
import '../../src/home/presentation/pages/create_update.dart';
import '../../src/home/presentation/pages/home_page.dart';

final routers = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: LoginPage.route,
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: HomePage.route,
      path: '/home-page',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      name: CreateUpdatePage.route,
      path: '/create-update-page',
      builder: (context, state) => CreateUpdatePage(
        taskEntity: state.extra as TaskEntity?,
      ),
    ),
    GoRoute(
      name: SearchPage.route,
      path: '/search-page',
      builder: (context, state) => SearchPage(),
    ),
  ],
);
