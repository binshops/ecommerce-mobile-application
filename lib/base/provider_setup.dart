import 'package:prestashop_mobile_app/providers/bottom_navigation.dart';
import 'package:prestashop_mobile_app/providers/products_and_category_provider.dart';
import 'package:prestashop_mobile_app/providers/search_provider.dart';
import 'package:prestashop_mobile_app/services/authentication_service.dart';
import 'package:prestashop_mobile_app/services/navigation_service.dart';
import 'package:prestashop_mobile_app/services/web_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];
List<SingleChildWidget> independentServices = [
  Provider.value(value: NavigationService()),
  Provider.value(value: AuthenticationService()),
  ListenableProvider.value(value: SearchProvider()),
  ListenableProvider.value(value: ProductAndCategoryProvider()),
  ListenableProvider.value(value: BottomNavigation()),
];
List<SingleChildWidget> dependentServices = [
  ProxyProvider<AuthenticationService, WebService>(
    update: (context, authenticationService, webService) => webService == null
        ? WebService(
            authenticationService: authenticationService,
          )
        : webService.setDependencies(authenticationService),
    create: (context) => WebService(),
  ),
];
