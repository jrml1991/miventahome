import 'package:miventahome/models/models.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._init();

  static Database? _db;

  LocalDatabase._init();

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      // si la base de datos ya existe, no hacemos nada.
      return;
    }

    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'miventa_home_database.db');
      _db = await openDatabase(_path,
          version: _version, onCreate: onCreate, onUpgrade: onUpgrade);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database db, int version) async {
    const stringType = 'STRING';
    const textType = 'TEXT';
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER';
    const realType = 'REAL';
    String sql = "";

    //creando tabla de informacion de red automatico
    sql = """
              CREATE TABLE networkinfo (
                                    id $idType,
                                    marca $stringType,
                                    modelo $stringType,
                                    id_lectura $textType,
                                    telefono $stringType,
                                    datos $stringType,
                                    localizacion $stringType,
                                    latitud $stringType,
                                    longitud $stringType,
                                    estadoRed $stringType,
                                    tipoRed $stringType,
                                    tipoTelefono $integerType,
                                    esRoaming $stringType,
                                    nivelSignal $stringType,
                                    dB $stringType,
                                    enviado $stringType,
                                    fecha $stringType,
                                    rsrp $stringType,
                                    rsrq $stringType,
                                    rssi $stringType,
                                    rsrp_asu $stringType,
                                    rssi_asu $stringType,
                                    cqi $stringType,
                                    snr $stringType,
                                    cid $stringType,
                                    eci $stringType,
                                    enb $stringType,
                                    network_iso $stringType,
                                    network_mcc $stringType,
                                    network_mnc $stringType,
                                    pci $stringType,
                                    cgi $stringType,
                                    ci $stringType,
                                    lac $stringType,
                                    psc $stringType,
                                    rnc $stringType,
                                    operator_name $stringType,
                                    isManual $stringType,
                                    background $stringType,
                                    fechaCorta $stringType
                                    )
            """;

    await db.execute(sql);

    //creando tabla de informacion de red automatico
    sql = """
              CREATE TABLE manualnetworkinfo (
                                    id $idType,
                                    idLectura $textType,
                                    departamento $stringType,
                                    municipio $stringType,
                                    zona $stringType,
                                    ambiente $stringType,
                                    tipoAmbiente $stringType,
                                    descripcionAmbiente $stringType,
                                    comentarios $stringType,
                                    colonia $stringType,
                                    fallaDesde $stringType,
                                    horas $stringType,
                                    tipoAfectacion $stringType,
                                    afectacion $stringType,
                                    fotografia $textType,
                                    enviado $stringType,
                                    mbSubida $realType,
                                    mbBajada $realType
                                    )
            """;

    await db.execute(sql);

    //creando tabla de usuarios
    sql = """
              CREATE TABLE usuario (
                                    id $idType,
                                    flag $stringType,
                                    iddms $stringType,
                                    usuario $stringType,
                                    nombre $stringType,
                                    identidad $stringType,
                                    territorio $stringType,
                                    perfil $integerType,
                                    telefono $stringType,
                                    correo $stringType,
                                    resultado $stringType,
                                    foto $textType
                                    )
            """;
    await db.execute(sql);
  }

  static void onUpgrade(Database db, int oldVersion, int version) async {
    if (oldVersion > version) {
      //crear nuevos objetos tablas de la nueva version
    }
  }

  static Future<List<Map<String, dynamic>>> customQuery(String query) async {
    List<Map<String, dynamic>> resp = await _db!.rawQuery(query);
    return resp;
  }

  static Future<List<Map<String, dynamic>>> query(String table,
      {String find = '1=?', int findValue = 1}) async {
    return _db!.query(
      table,
      where: find,
      whereArgs: [findValue],
      orderBy: "id DESC",
    );
  }

  static Future<int> insert(String table, Model model) async {
    return _db!.insert(table, model.toJson());
  }

  static Future<int> update(String table, Model model) async {
    return _db!
        .update(table, model.toJson(), where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> delete(String table, Model model) async {
    return _db!
        .update(table, model.toJson(), where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> deleteTable(String table) async {
    return _db!.delete(table);
  }
}
