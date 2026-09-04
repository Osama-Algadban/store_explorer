// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:store_explorer/core/managers/api_manager/api_manager.dart'
    as _i408;
import 'package:store_explorer/features/products/data/data_sources/products_remote_data_source.dart'
    as _i851;
import 'package:store_explorer/features/products/data/repositories/products_repository_impl.dart'
    as _i676;
import 'package:store_explorer/features/products/domain/repositories/products_repository.dart'
    as _i804;
import 'package:store_explorer/features/products/domain/use_cases/products_search_use_cases.dart'
    as _i882;
import 'package:store_explorer/features/products/domain/use_cases/products_use_cases.dart'
    as _i1046;
import 'package:store_explorer/features/products/presentation/manager/products_bloc.dart'
    as _i356;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i882.ProductsSearchUseCases>(
      () => _i882.ProductsSearchUseCases(),
    );
    gh.lazySingleton<_i1046.ProductsUseCases>(() => _i1046.ProductsUseCases());
    gh.lazySingleton<_i851.ProductsRemoteDataSource>(
      () => _i851.ProductsRemoteDataSourceImpl(),
    );
    gh.factory<_i356.ProductsBloc>(
      () => _i356.ProductsBloc(
        gh<_i1046.ProductsUseCases>(),
        gh<_i882.ProductsSearchUseCases>(),
      ),
    );
    gh.singleton<_i408.ApiManager>(() => _i408.ApiManagerImpl());
    gh.lazySingleton<_i804.ProductsRepository>(
      () => _i676.ProductsRepositoryImpl(gh<_i851.ProductsRemoteDataSource>()),
    );
    return this;
  }
}
