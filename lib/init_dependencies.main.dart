part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  initAuth();
  initBlog();

  final supabase = await Supabase.initialize(
    url: SupabaseSecret.projectUrl,
    anonKey: SupabaseSecret.anonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator
    ..registerLazySingleton(
          () => supabase.client,
    )
    ..registerFactory(
          () => InternetConnection(),
    )
    ..registerLazySingleton(
          () => Hive.box(name: 'blogs'),
    );

  // core
  serviceLocator
    ..registerLazySingleton(
          () => UserCubit(),
    )
    ..registerFactory<ConnectionChecker>(
          () => ConnectionCheckerImpl(
        serviceLocator(),
      ),
    );
}

void initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
          () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
          () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
          () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    ..registerFactory(
          () => UploadBlog(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
          () => GetBlogs(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
          () => BlogBloc(
        uploadBlog: serviceLocator(),
        getBlogs: serviceLocator(),
      ),
    );
}

void initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
          () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    ..registerFactory(
          () => UserSignUp(
        serviceLocator(),
      ),
    )

  // for login
    ..registerFactory(
          () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
          () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
          () => AuthBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}
