import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/apod/data/datasources/local/apod_local_data_source.dart';
import 'features/apod/data/datasources/remote/apod_api_service.dart';
import 'features/apod/data/repositories/apod_repository_impl.dart';
import 'features/apod/data/models/astronomy_picture_model.dart';
import 'features/apod/domain/repository/apod_repository.dart';
import 'features/apod/domain/usecases/get_apod_usecase.dart'; // Import this
import 'features/apod/presentation/bloc/apod_bloc.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_case/auth_usecases.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/neo/data/datasources/local/neo_local_data_source.dart';
import 'features/neo/data/datasources/remote/neo_api_service.dart';
import 'features/neo/data/models/neo_model.dart';
import 'features/neo/data/repository_impl/neo_repository_impl.dart';
import 'features/neo/domain/repository/neo_repository.dart';
import 'features/neo/domain/use_case/get_neo_list_usecase.dart';
import 'features/neo/presentation/bloc/neo_bloc.dart';
import 'features/solar/data/datasource/local/solar_local_data_source.dart';
import 'features/solar/data/datasource/remote/solar_api_service.dart';
import 'features/solar/data/models/solar_notification_model.dart';
import 'features/solar/data/repository/solar_repository_impl.dart';
import 'features/solar/domain/repository/solar_repository.dart';
import 'features/solar/domain/use_case/get_solar_notifications_usecase.dart';
import 'features/solar/presentation/bloc/solar_bloc.dart'; // Import this

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // 1. External
  await Hive.initFlutter();
  Hive.registerAdapter(AstronomyPictureModelAdapter());
  final apodBox = await Hive.openBox<AstronomyPictureModel>('apod_box');

  sl.registerSingleton<Dio>(Dio());

  // 2. Data Sources
  sl.registerSingleton<ApodApiService>(ApodApiService(sl()));

  sl.registerSingleton<ApodLocalDataSource>(
    ApodLocalDataSourceImpl(apodBox: apodBox),
  );

  // 3. Repositories
  sl.registerSingleton<ApodRepository>(ApodRepositoryImpl(sl(), sl()));

  // --- NEW ADDITIONS ---

  // 4. UseCases
  sl.registerSingleton<GetApodUseCase>(GetApodUseCase(sl()));

  // 5. Blocs
  // We use registerFactory for Blocs so a new instance is created every time the UI needs it
  sl.registerFactory<ApodBloc>(() => ApodBloc(sl()));

  // Register Adapter for NEO
  Hive.registerAdapter(NeoModelAdapter());
  final neoBox = await Hive.openBox<NeoModel>('neo_box');

  // ... existing Dio

  // --- NEO FEATURE ---
  // Data Sources
  sl.registerSingleton<NeoApiService>(NeoApiService(sl()));
  sl.registerSingleton<NeoLocalDataSource>(
    NeoLocalDataSourceImpl(neoBox: neoBox),
  );

  // Repository
  sl.registerSingleton<NeoRepository>(NeoRepositoryImpl(sl(), sl()));

  // UseCase
  sl.registerSingleton<GetNeoListUseCase>(GetNeoListUseCase(sl()));

  // Bloc
  sl.registerFactory<NeoBloc>(() => NeoBloc(sl()));
  // 1. Register Adapter
  Hive.registerAdapter(SolarNotificationModelAdapter());
  final solarBox = await Hive.openBox<SolarNotificationModel>('solar_box');

  // 2. Data Sources
  sl.registerSingleton<SolarApiService>(SolarApiService(sl()));
  sl.registerSingleton<SolarLocalDataSource>(
    SolarLocalDataSourceImpl(solarBox: solarBox),
  );

  // 3. Repository
  sl.registerSingleton<SolarRepository>(SolarRepositoryImpl(sl(), sl()));

  // 4. Use Case
  sl.registerSingleton<GetSolarNotificationsUseCase>(
    GetSolarNotificationsUseCase(sl()),
  );

  // 5. Bloc
  sl.registerFactory<SolarBloc>(() => SolarBloc(sl()));

  // --- AUTH ---
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase(sl()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl()));

  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl()));
}
