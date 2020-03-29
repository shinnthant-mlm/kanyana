
import 'package:kanyana/models/mark_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MarkDatabase{
  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'markdb.db');
    var database = await openDatabase(dbPath, version: 1, onCreate:populateDb );
    return database;
  }
  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE tblMark ("
        "questionSet TEXT PRIMARY KEY,"
        "mark int"
        ")");
    await database.close();
  }
  void createDefaultMarks() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'markdb.db');
    print(dbPath);
    try {
      var database = await openDatabase(dbPath);
      for (int i = 1; i < 6; i++) {
        await database.rawInsert(
            "INSERT INTO tblMark (questionSet,mark)"
                " VALUES ('Question Set $i',0)");
      }

      await database.close();
    }
    catch(err){
      print('Already Created');
    }
  }

    Future<int> updateMark(Marks marks) async {
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'markdb.db');

      var database=await openDatabase(dbPath);
      int result= await database.rawUpdate(
          'UPDATE tblMark SET mark = "${marks.mark}" WHERE questionSet = "${marks.questionSet}"'
      );
     await database.close();
      return result;
    }

    Future<List<Map<String, dynamic>>> getData()async{
      String databasesPath = await getDatabasesPath();
      String dbPath = join(databasesPath, 'markdb.db');
      var database=await openDatabase(dbPath);
      List<Map<String, dynamic>> mapList= await database.rawQuery('SELECT * FROM tblMark');
      await database.close();
      return mapList;
    }



  }
