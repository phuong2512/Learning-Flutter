import 'package:flutter/material.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/change_profile_screen.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/home_screen.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/profile_screen.dart';
import 'package:learning_flutter/flutter/navigate/navigation/router/settings_screen.dart';

class AppRouteState {
  String? screen;
  int? id;

  AppRouteState({this.screen, this.id});

  static AppRouteState home() => AppRouteState(screen: 'home');
  static AppRouteState profile(int id) =>
      AppRouteState(screen: 'profile', id: id);
  static AppRouteState settings() => AppRouteState(screen: 'settings');
  static AppRouteState changeProfile() =>
      AppRouteState(screen: 'change_profile');
}

class AppRouteParser extends RouteInformationParser<AppRouteState> {
  @override
  Future<AppRouteState> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isEmpty) return AppRouteState.home();

    if (uri.pathSegments.first == 'profile') {
      final id = int.tryParse(uri.queryParameters['id'] ?? '');
      return AppRouteState.profile(id ?? 0);
    }

    if (uri.pathSegments.first == 'settings') {
      if (uri.pathSegments.length > 1 &&
          uri.pathSegments[1] == 'change_profile') {
        return AppRouteState.changeProfile();
      }
      return AppRouteState.settings();
    }

    return AppRouteState.home();
  }
}

class AppRouterDelegate extends RouterDelegate<AppRouteState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final List<AppRouteState> _history = [AppRouteState.home()];

  @override
  AppRouteState get currentConfiguration => _history.last;

  @override
  Widget build(BuildContext context) {
    final pages = <Page>[
      const MaterialPage(key: ValueKey('home'), child: HomeScreen()),
    ];

    for (final state in _history.skip(1)) {
      switch (state.screen) {
        case 'profile':
          pages.add(
            MaterialPage(
              key: ValueKey('profile${state.id}'),
              child: ProfileScreen(id: state.id!),
            ),
          );
          break;
        case 'settings':
          pages.add(
            const MaterialPage(
              key: ValueKey('settings'),
              child: SettingsScreen(),
            ),
          );
          break;
        case 'change_profile':
          pages.add(
            const MaterialPage(
              key: ValueKey('change_profile'),
              child: ChangeProfileScreen(),
            ),
          );
          break;
      }
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        if (_history.length > 1) {
          _history.removeLast();
          notifyListeners();
          return true;
        }
        return false;
      },
    );
  }

  void goToProfile(int id) {
    _history.add(AppRouteState.profile(id));
    notifyListeners();
  }

  void goToSettings() {
    _history.add(AppRouteState.settings());
    notifyListeners();
  }

  void goToChangeProfile() {
    _history.add(AppRouteState.changeProfile());
    notifyListeners();
  }

  void goBack() {
    if (_history.length > 1) {
      _history.removeLast();
      notifyListeners();
    }
  }

  void goBackHome() {
    _history.clear();
    _history.add(AppRouteState.home());
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(AppRouteState state) async {
    _history.clear();
    _history.add(AppRouteState.home());

    switch (state.screen) {
      case 'profile':
        _history.add(AppRouteState.profile(state.id ?? 0));
        break;
      case 'settings':
        _history.add(AppRouteState.settings());
        break;
      case 'change_profile':
        _history.addAll([
          AppRouteState.settings(),
          AppRouteState.changeProfile(),
        ]);
        break;
    }
  }
}

class AppBackButtonDispatcher extends RootBackButtonDispatcher {
  final AppRouterDelegate routerDelegate;

  AppBackButtonDispatcher(this.routerDelegate);

  @override
  Future<bool> didPopRoute() async {
    routerDelegate.goBack();
    return true;
  }
}
