import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/surat_remote_data_source.dart';
import '../../data/datasources/pengajuan_remote_data_source.dart';
import '../../data/datasources/warga_remote_data_source.dart';
import '../../data/datasources/kartu_keluarga_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/surat_repository_impl.dart';
import '../../data/repositories/pengajuan_repository_impl.dart';
import '../../data/repositories/warga_repository_impl.dart';
import '../../data/repositories/kartu_keluarga_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/surat_repository.dart';
import '../../domain/repositories/pengajuan_repository.dart';
import '../../domain/repositories/warga_repository.dart';
import '../../domain/repositories/kartu_keluarga_repository.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../../domain/usecases/surat_usecase.dart';
import '../../domain/usecases/pengajuan_usecase.dart';
import '../../domain/usecases/warga_usecase.dart';
import '../../domain/usecases/kartu_keluarga_usecase.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/surat/surat_bloc.dart';
import '../../presentation/blocs/warga/warga_bloc.dart';
import '../../presentation/blocs/kartu_keluarga/kartu_keluarga_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/blocs/pengajuan_rt/pengajuan_rt_event.dart';
import '../../presentation/blocs/pengajuan_rt/pengajuan_rt_state.dart';
import '../../presentation/blocs/pengajuan_rt/pengajuan_rt_bloc.dart';
import '../../presentation/pages/rt/pengajuan_rt_page.dart';
import '../../domain/entities/user.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiClient>(), getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<SuratRemoteDataSource>(
    () => SuratRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<PengajuanRemoteDataSource>(
    () => PengajuanRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<WargaRemoteDataSource>(
    () => WargaRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  getIt.registerLazySingleton<KartuKeluargaRemoteDataSource>(
    () => KartuKeluargaRemoteDataSourceImpl(getIt<ApiClient>()),
  );
  
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<AuthLocalDataSource>(),
    ),
  );
  getIt.registerLazySingleton<SuratRepository>(
    () => SuratRepositoryImpl(getIt<SuratRemoteDataSource>()),
  );
  getIt.registerLazySingleton<PengajuanRepository>(
    () => PengajuanRepositoryImpl(getIt<PengajuanRemoteDataSource>()),
  );
  getIt.registerLazySingleton<WargaRepository>(
    () => WargaRepositoryImpl(getIt<WargaRemoteDataSource>()),
  );
  getIt.registerLazySingleton<KartuKeluargaRepository>(
    () => KartuKeluargaRepositoryImpl(getIt<KartuKeluargaRemoteDataSource>()),
  );
  
  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => IsLoggedInUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetSuratListUseCase(getIt<SuratRepository>()));
  getIt.registerLazySingleton(() => GetSuratByIdUseCase(getIt<SuratRepository>()));
  getIt.registerLazySingleton(() => GetPengajuanListUseCase(getIt<PengajuanRepository>()));
  getIt.registerLazySingleton(() => GetPengajuanByIdUseCase(getIt<PengajuanRepository>()));
  getIt.registerLazySingleton(() => CreatePengajuanUseCase(getIt<PengajuanRepository>()));
  getIt.registerLazySingleton(() => UpdatePengajuanUseCase(getIt<PengajuanRepository>()));
  getIt.registerLazySingleton(() => DeletePengajuanUseCase(getIt<PengajuanRepository>()));
  getIt.registerLazySingleton(() => GetAnggotaKeluargaByUserIDUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => GetWargaByNoKKUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => GetWargaByNIKUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => GetKepalaKeluargaByNoKKUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => GetAnggotaKeluargaByNoKKUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => GetAllWargaUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => CreateWargaUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => UpdateWargaUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => DeleteWargaUseCase(getIt<WargaRepository>()));
  getIt.registerLazySingleton(() => GetKartuKeluargaByNoKKUseCase(getIt<KartuKeluargaRepository>()));
  
  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt<LoginUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      isLoggedInUseCase: getIt<IsLoggedInUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => SuratBloc(
      getSuratListUseCase: getIt<GetSuratListUseCase>(),
      getSuratByIdUseCase: getIt<GetSuratByIdUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => WargaBloc(
      getAnggotaKeluargaByUserIDUseCase: getIt<GetAnggotaKeluargaByUserIDUseCase>(),
    ),
  );
  getIt.registerFactory(
    () => KartuKeluargaBloc(
      getKartuKeluargaByNoKKUseCase: getIt<GetKartuKeluargaByNoKKUseCase>(),
    ),
  );
  getIt.registerFactory(() => PengajuanRTBloc(
    getPengajuanListByRTUseCase: getIt<GetPengajuanListByRTUseCase>(),
    approvePengajuanByRTUseCase: getIt<ApprovePengajuanByRTUseCase>(),
    rejectPengajuanByRTUseCase: getIt<RejectPengajuanByRTUseCase>(),
  ));
  getIt.registerLazySingleton(() => GetPengajuanListByRTUseCase(getIt()));
  getIt.registerLazySingleton(() => ApprovePengajuanByRTUseCase(getIt()));
  getIt.registerLazySingleton(() => RejectPengajuanByRTUseCase(getIt()));
} 

Future<int> getRtIdForUser(User user) async {
  if (user.wargaId == null) return 0;

  final wargaRemoteDataSource = getIt<WargaRemoteDataSource>();
  final warga = await wargaRemoteDataSource.getWargaById(user.wargaId!);
  if (warga == null) return 0;

  final kkRemoteDataSource = getIt<KartuKeluargaRemoteDataSource>();
  final kk = await kkRemoteDataSource.getKartuKeluargaByNoKK(warga.noKK);
  if (kk == null) return 0;

  return kk.rtId;
} 