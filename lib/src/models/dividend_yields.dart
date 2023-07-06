class DividendYield {
  int _id = 0;
  String _mes = "";
  double _valorAplicado = 0;
  double _valorBruto = 0;
  double _rentabilidadeNoMes = 0;
  double _dy = 0;
  double _dyOnCost = 0;
  int _anoAtual = 1;

  DividendYield(this._id, this._mes, this._valorAplicado, this._valorBruto,
      this._rentabilidadeNoMes, this._dy, this._dyOnCost);

  int get id => _id;

  set id(int id) => _id = id;

  String get mes => _mes;

  set mes(String mes) => _mes = mes;

  double get valorAplicado => _valorAplicado;

  set valorAplicado(double valorAplicado) => _valorAplicado = valorAplicado;

  double get valorBruto => _valorBruto;

  set valorBruto(double valorBruto) => _valorBruto = valorBruto;

  double get rentabilidadeNoMes => _rentabilidadeNoMes;

  set rentabilidadeNoMes(double rentabilidadeNoMes) =>
      _rentabilidadeNoMes = rentabilidadeNoMes;

  double get dy => _dy;

  set dy(double dy) => _dy = dy;

  double get dyOnCost => _dyOnCost;

  set dyOnCost(double dyOnCost) => _dyOnCost = dyOnCost;

  int get anoAtual => _anoAtual;

  set anoAtual(int anoAtual) => _anoAtual = anoAtual;
}
