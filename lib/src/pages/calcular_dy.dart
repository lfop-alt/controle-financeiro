import 'package:fii_finance/src/models/dividend_yields.dart';
import 'package:fii_finance/src/pages/dashboard_page.dart';
import 'package:fii_finance/src/repositories/dividend_yields_repository.dart';
import 'package:fii_finance/src/services/calcular_dy_service.dart';
import 'package:flutter/material.dart';

List<String> meses = <String>[
  "Janeiro",
  "Fevereiro",
  "Março",
  "Abril",
  "Maio",
  "Junho",
  "Julho",
  "Agosto",
  "Setembro",
  "Outubro",
  "Novembro",
  "Dezembro",
];

List<String> anos = <String>[
  "2020",
  "2021",
  "2022",
  "2023",
  "2024",
  "2025",
  "2026",
  "2027"
];

class CalcularDY extends StatefulWidget {
  const CalcularDY({super.key});

  @override
  State<CalcularDY> createState() => _CalcularDYState();
}

class _CalcularDYState extends State<CalcularDY> {
  DividendYieldRepository dividendYieldRepository = DividendYieldRepository();
  var mes;
  int ano = DateTime.now().year;

  TextEditingController valorAplicadoController = TextEditingController();
  TextEditingController saldoBrutoController = TextEditingController();
  TextEditingController rendimentoDoMesController = TextEditingController();
  var anoDropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir DY"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Text(
                  "Calcular Dy e Dy on cost",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                )),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    menuMaxHeight: 500,
                    hint: const Text("Selecione o mês"),
                    isExpanded: false,
                    value: mes,
                    items: [
                      DropdownMenuItem(
                        value: 0,
                        child: Text(meses[0]),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text(meses[1]),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text(meses[2]),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text(meses[3]),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text(meses[4]),
                      ),
                      DropdownMenuItem(
                        value: 5,
                        child: Text(meses[5]),
                      ),
                      DropdownMenuItem(
                        value: 6,
                        child: Text(meses[6]),
                      ),
                      DropdownMenuItem(
                        value: 7,
                        child: Text(meses[7]),
                      ),
                      DropdownMenuItem(
                        value: 8,
                        child: Text(meses[8]),
                      ),
                      DropdownMenuItem(
                        value: 9,
                        child: Text(meses[9]),
                      ),
                      DropdownMenuItem(
                        value: 10,
                        child: Text(meses[10]),
                      ),
                      DropdownMenuItem(
                        value: 11,
                        child: Text(meses[11]),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        mes = value ?? meses[0];
                      });
                    },
                  ),
                ),
                DropdownButton(
                  value: anoDropdown,
                  hint: const Text("Selecione o Ano"),
                  items: [
                    DropdownMenuItem(value: anos[0], child: Text(anos[0])),
                    DropdownMenuItem(
                      value: anos[1],
                      child: Text(anos[1]),
                    ),
                    DropdownMenuItem(
                      value: anos[2],
                      child: Text(anos[2]),
                    ),
                    DropdownMenuItem(
                      value: anos[3],
                      child: Text(anos[3]),
                    ),
                    DropdownMenuItem(
                      value: anos[4],
                      child: Text(anos[4]),
                    ),
                    DropdownMenuItem(
                      value: anos[5],
                      child: Text(anos[5]),
                    ),
                    DropdownMenuItem(
                      value: anos[6],
                      child: Text(anos[6]),
                    ),
                    DropdownMenuItem(
                      value: anos[7],
                      child: Text(anos[7]),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      anoDropdown = value ?? anos[0];
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: const Text("Valor Aplicado"),
              ),
              keyboardType: TextInputType.number,
              controller: valorAplicadoController,
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: const Text("Saldo bruto"),
              ),
              keyboardType: TextInputType.number,
              controller: saldoBrutoController,
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                label: const Text("Rendimento recebido no mês"),
              ),
              keyboardType: TextInputType.number,
              controller: rendimentoDoMesController,
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.grey[850])),
                  onPressed: () async {
                    double dy = double.parse(CalcularDyService(
                            double.parse(valorAplicadoController.text),
                            double.parse(saldoBrutoController.text),
                            double.parse(rendimentoDoMesController.text))
                        .calculoDy()
                        .toStringAsPrecision(2));
                    double dyOnCost = double.parse(CalcularDyService(
                            double.parse(valorAplicadoController.text),
                            double.parse(saldoBrutoController.text),
                            double.parse(rendimentoDoMesController.text))
                        .calculoDyOnCast()
                        .toStringAsPrecision(2));

                    await dividendYieldRepository.save(DividendYield(
                        0,
                        meses[mes],
                        double.parse(valorAplicadoController.text),
                        double.parse(saldoBrutoController.text),
                        double.parse(rendimentoDoMesController.text),
                        dy,
                        dyOnCost,
                        int.parse(anoDropdown)));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DashboardPage(),
                        ));
                  },
                  child: const Text("Salvar")),
            ),
          ],
        ),
      ),
    );
  }
}
