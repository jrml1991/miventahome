import 'package:intl/intl.dart';
import 'package:miventahome/localdb/local_database.dart';
import 'package:miventahome/models/models.dart';

class DBService {
  /*INICIO FUNCIONES PARA USUARIO*/
  Future<List<Usuario>> getUsuario() async {
    await LocalDatabase.init();

    List<Map<String, dynamic>> usuario =
        await LocalDatabase.query(Usuario.table);

    return usuario.map((item) => Usuario.fromMap(item)).toList();
  }

  Future<bool> addUsuario(Usuario model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(Usuario.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> updateUsuario(Usuario model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(Usuario.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> deleteUsuario() async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.deleteTable(Usuario.table);

    return resp > 0 ? true : false;
  }

  /* FIN EVENTOS PARA USUARIO*/

  /*INICIO FUNCIONES PARA TRACKING DE RED*/
  Future<List<NetworkInfo>> getInformacion() async {
    await LocalDatabase.init();

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.query(NetworkInfo.table);
    return networkInfo.map((item) => NetworkInfo.fromMap(item)).toList();
  }

  Future<List<NetworkInfo>> getInformacionPorLectura(String idLectura) async {
    await LocalDatabase.init();
    final query = """
                    SELECT *
                    FROM networkinfo
                    WHERE id_lectura = '$idLectura' 
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo.map((item) => NetworkInfo.fromMap(item)).toList();
  }

  Future<List<int>> getInformacionDia() async {
    await LocalDatabase.init();

    String hoy = DateFormat.yMd().format(DateTime.now());

    final query = """
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'SI' 
                        AND fechaCorta = '$hoy'               
                    UNION ALL
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'NO'
                        AND fechaCorta = '$hoy'
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo
        .map((item) => int.parse(item.entries.first.value.toString()))
        .toList();
  }

  Future<List<int>> getInformacionMes() async {
    await LocalDatabase.init();
    const query = """
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'SI'
                    UNION ALL
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'NO'
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo
        .map((item) => int.parse(item.entries.first.value.toString()))
        .toList();
  }

  Future<List<int>> getInformacionSinSincronizar() async {
    await LocalDatabase.init();
    const query = """
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'SI'
                          AND enviado = 'NO'
                    UNION ALL
                    SELECT COUNT(*) cantidad
                    FROM networkinfo
                    WHERE background = 'NO'
                          AND enviado = 'NO'
                  """;

    List<Map<String, dynamic>> networkInfo =
        await LocalDatabase.customQuery(query);
    return networkInfo
        .map((item) => int.parse(item.entries.first.value.toString()))
        .toList();
  }

  Future<bool> addInformacion(NetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(NetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> updateInformacion(NetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(NetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> deleteInformacion(NetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.delete(NetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  /*INICIO FUNCIONES PARA TRACKING DE RED CAPTURA MANUAL*/
  Future<List<ManualNetworkInfo>> getInformacionManual() async {
    await LocalDatabase.init();

    List<Map<String, dynamic>> manualNetworkInfo =
        await LocalDatabase.query(ManualNetworkInfo.table);
    return manualNetworkInfo
        .map((item) => ManualNetworkInfo.fromMap(item))
        .toList();
  }

  Future<bool> addInformacionManual(ManualNetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.insert(ManualNetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> updateInformacionManual(ManualNetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.update(ManualNetworkInfo.table, model);

    return resp > 0 ? true : false;
  }

  Future<bool> deleteInformacionManual(ManualNetworkInfo model) async {
    await LocalDatabase.init();

    int resp = await LocalDatabase.delete(ManualNetworkInfo.table, model);

    return resp > 0 ? true : false;
  }
}
