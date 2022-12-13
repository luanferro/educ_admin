import 'package:educ_admin/layers/data/datasources/adicionar_pontos_datasource.dart';
import 'package:educ_admin/layers/data/datasources/buscar_aluno_datasource.dart';
import 'package:educ_admin/layers/data/datasources/buscar_notas_datasource.dart';
import 'package:educ_admin/layers/data/datasources/buscar_usuario_datasource.dart';
import 'package:educ_admin/layers/data/datasources/firebase/adicionar_pontos_datasource_imp.dart';
import 'package:educ_admin/layers/data/datasources/firebase/buscar_aluno_datasource_imp.dart';
import 'package:educ_admin/layers/data/datasources/firebase/buscar_notas_datasource_imp.dart';
import 'package:educ_admin/layers/data/datasources/firebase/buscar_usuario_datasource_imp.dart';
import 'package:educ_admin/layers/data/datasources/firebase/login_datasource_imp.dart';
import 'package:educ_admin/layers/data/datasources/login_datasource.dart';
import 'package:educ_admin/layers/data/repositories/aluno_repository_imp.dart';
import 'package:educ_admin/layers/data/repositories/nota_repository_imp.dart';
import 'package:educ_admin/layers/data/repositories/usuario_repository_imp.dart';
import 'package:educ_admin/layers/domain/repositories/aluno_repository.dart';
import 'package:educ_admin/layers/domain/repositories/nota_repository.dart';
import 'package:educ_admin/layers/domain/repositories/usuario_repository.dart';
import 'package:educ_admin/layers/domain/usecases/adicionar_pontos/adicionar_pontos_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/adicionar_pontos/adicionar_pontos_usecase_imp.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_admin/buscar_admin_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_admin/buscar_admin_usecase_imp.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_alunos/buscar_alunos_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_alunos/buscar_alunos_usecase_imp.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_foto_perfil/buscar_foto_perfil_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_foto_perfil/buscar_foto_perfil_usecase_imp.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_notas/buscar_notas_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_notas/buscar_notas_usecase_imp.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_usuario/buscar_usuario_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/buscar_usuario/buscar_usuario_usecase_imp.dart';
import 'package:educ_admin/layers/domain/usecases/login/login_usecase.dart';
import 'package:educ_admin/layers/domain/usecases/login/login_usecase_imp.dart';
import 'package:educ_admin/layers/presentation/controllers/aluno_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/nota_controller.dart';
import 'package:educ_admin/layers/presentation/controllers/usuario_controller.dart';
import 'package:get_it/get_it.dart';

import '../../layers/data/datasources/buscar_alunos_datasource.dart';
import '../../layers/data/datasources/firebase/buscar_alunos_datasource_imp.dart';

class Inject {
  static void init() {
    GetIt getIt = GetIt.instance;

    //datasources

    getIt.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImp());

    getIt.registerLazySingleton<BuscarNotasDataSource>(
        () => BuscarNotasDataSourceImp());

    getIt.registerLazySingleton<AdicionarPontosDataSource>(
        () => AdicionarPontosDataSourceImp());

    getIt.registerLazySingleton<BuscarUsuarioDataSource>(
        () => BuscarUsuarioDataSourceImp());

    getIt.registerLazySingleton<BuscarAlunoDataSource>(
        () => BuscarAlunoDataSourceImp());

    getIt.registerLazySingleton<BuscarAlunosDataSource>(
        () => BuscarAlunosDataSourceImp());

    //repositories
    getIt.registerLazySingleton<UsuarioRepository>(
        () => UsuarioRepositoryImp(getIt(), getIt()));

    getIt.registerLazySingleton<AlunoRepository>(
        () => AlunoRepositoryImp(getIt(), getIt(), getIt()));

    getIt.registerLazySingleton<NotaRepository>(
        () => NotaRepositoryImp(getIt()));
    //usecases
    getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCaseImp(getIt()));

    getIt.registerLazySingleton<BuscarAdminUseCase>(
        () => BuscarAdminUseCaseImp(getIt()));

    getIt.registerLazySingleton<BuscarNotasUseCase>(
        () => BuscarNotasUseCaseImp(getIt()));

    getIt.registerLazySingleton<BuscarUsuarioUseCase>(
        () => BuscarUsuarioUseCaseImp(getIt()));

    getIt.registerLazySingleton<BuscarAlunosUseCase>(
        () => BuscarAlunosUseCaseImp(getIt()));

    getIt.registerLazySingleton<BuscarFotoPerfilUseCase>(
        () => BuscarFotoPerfilUseCaseImp(getIt()));

    getIt.registerLazySingleton<AdicionarPontosUseCase>(
        () => AdicionarPontosUseCaseImp(getIt()));
    //controllers
    getIt.registerLazySingleton<UsuarioController>(
        () => UsuarioController(getIt(), getIt()));

    getIt.registerLazySingleton<AlunoController>(
        () => AlunoController(getIt(), getIt(), getIt(), getIt()));

    getIt.registerLazySingleton<NotaController>(() => NotaController(getIt()));
  }
}
