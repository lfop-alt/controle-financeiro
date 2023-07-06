class CalcularDyService {
  double valorBruto = 0;
  double valorAplicado = 0;
  double rendimentoRecebido = 0;

  CalcularDyService(
      this.valorAplicado, this.valorBruto, this.rendimentoRecebido);

  double calculoDy() {
    return (rendimentoRecebido / valorAplicado) * 100;
  }

  double calculoDyOnCast() {
    return (rendimentoRecebido / valorBruto) * 100;
  }
}
