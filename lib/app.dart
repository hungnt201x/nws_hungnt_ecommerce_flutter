import 'package:ecommerce/blocs/app_cubit.dart';
import 'package:ecommerce/network/api_client.dart';
import 'package:ecommerce/network/api_util.dart';
import 'package:ecommerce/repositories/auth_repository.dart';
import 'package:ecommerce/repositories/cart_repository.dart';
import 'package:ecommerce/repositories/category_repository.dart';
import 'package:ecommerce/repositories/notification_repository.dart';
import 'package:ecommerce/repositories/product_repository.dart';
import 'package:ecommerce/repositories/user_repository.dart';
import 'package:ecommerce/router/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.apiClient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<CategoryRepository>(
          create: (context) {
            return CategoryRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) {
            return ProductRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<UserRepository>(
          create: (context) {
            return UserRepositoryImpl(apiClient: _apiClient);
          },
        ),
        RepositoryProvider<CartRepository>(
          create: (context) {
            return CartRepositoryImpl();
          },
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) {
            return NotificationRepositoryImpl();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) {
              return AppCubit(
                  userRepository:
                      RepositoryProvider.of<UserRepository>(context),
                  authRepository:
                      RepositoryProvider.of<AuthRepository>(context));
            },
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
