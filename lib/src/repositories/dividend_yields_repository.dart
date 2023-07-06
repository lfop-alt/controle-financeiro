import 'package:fii_finance/src/models/db/db_connect.dart';
import 'package:fii_finance/src/models/dividend_yields.dart';

class DividendYieldRepository {
  Future<List<DividendYield>> listarDy(bool anoAtual) async {
    List<DividendYield> dys = [];
    var db = await DatabaseSQLite().getDatabase();
    var result = await db.rawQuery(anoAtual
        ? "SELECT id, mes, valorAplicado, valorBruto, rentabilidadeNoMes, dy, dyOnCost FROM dividendYield WHERE anoAtual = 1"
        : "SELECT id, mes, valorAplicado, valorBruto, rentabilidadeNoMes, dy, dyOnCost FROM dividendYield");
    for (var dy in result) {
      dys.add(
        DividendYield(
            int.parse(dy["id"].toString()),
            dy["mes"].toString(),
            double.parse(dy["valorAplicado"].toString()),
            double.parse(dy["valorBruto"].toString()),
            double.parse(
              dy["rentabilidadeNoMes"].toString(),
            ),
            double.parse(
              dy["dy"].toString(),
            ),
            double.parse(dy["dyOnCost"].toString())),
      );
    }

    return dys;
  }

  Future<void> save(DividendYield dividendYield) async {
    var db = await DatabaseSQLite().getDatabase();
    await db.rawInsert(
        "INSERT INTO dividendYield (mes, valorAplicado, valorBruto, rentabilidadeNoMes, dy, dyOnCost) values (?,?,?,?,?,?)",
        [
          dividendYield.mes,
          dividendYield.valorAplicado,
          dividendYield.valorBruto,
          dividendYield.rentabilidadeNoMes,
          dividendYield.dy,
          dividendYield.dyOnCost
        ]);
  }

  Future<void> deleteDividend(int id) async {
    var db = await DatabaseSQLite().getDatabase();
    await db.rawDelete("DELETE FROM dividendYield WHERE id = ?", [id]);
  }
}
