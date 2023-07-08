import 'package:fii_finance/src/components/drawer_custom.dart';
import 'package:fii_finance/src/pages/calcular_dy.dart';

import 'package:flutter/material.dart';

import '../models/dividend_yields.dart';
import '../repositories/dividend_yields_repository.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DividendYieldRepository dividendYieldRepository = DividendYieldRepository();

  var _dividends = <DividendYield>[];
  bool ano = true;

  @override
  void initState() {
    initDividend();
    super.initState();
  }

  void initDividend() async {
    _dividends = await dividendYieldRepository.listarDy(ano);
    setState(() {});
  }

  double getAcumuladoDy() {
    double dyAcumulado = 0;
    if (ano) {
      for (var dy in _dividends) {
        dyAcumulado = dyAcumulado + dy.dy;
      }
    }

    return dyAcumulado;
  }

  double getAcumuladoDyOnCost() {
    double dyAcumulado = 0;
    if (ano) {
      for (var dy in _dividends) {
        dyAcumulado = dyAcumulado + dy.dyOnCost;
      }
    }

    return dyAcumulado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text("Pagina Inicial"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalcularDY(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color.fromARGB(255, 102, 102, 102),
              width: double.infinity,
              height: 40,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ano Atual",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Switch(
                      value: ano,
                      onChanged: (value) {
                        ano = value;
                        initDividend();
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: SizedBox(
                height: 550,
                child: ListView.builder(
                    itemCount: _dividends.length,
                    itemBuilder: (context, index) {
                      var dy = _dividends[index];

                      return Dismissible(
                        key: Key(dy.id.toString()),
                        onDismissed: (direction) {
                          dividendYieldRepository.deleteDividend(dy.id);
                          initDividend();
                        },
                        child: Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.blue,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.elliptical(5, 5),
                                          topRight: Radius.elliptical(5, 5)),
                                      color: Color.fromARGB(255, 102, 102, 102),
                                    ),
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Dividend Yield",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "${dy.mes}/${dy.ano}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Dividend Yield",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${dy.dy.toString()}%",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  indent: 8,
                                  endIndent: 8,
                                  color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Dividend Yield on Cost",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "${dy.dyOnCost.toString()}%",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  indent: 8,
                                  endIndent: 8,
                                  color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Valor Aplicado",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "R\$ ${dy.valorAplicado.toString()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  indent: 8,
                                  endIndent: 8,
                                  color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Valor Bruto",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "R\$ ${dy.valorBruto.toString()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  indent: 8,
                                  endIndent: 8,
                                  color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 2, 8, 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Rendimentos",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "R\$ ${dy.rentabilidadeNoMes.toString()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Container(
              height: 110,
              color: const Color.fromARGB(255, 102, 102, 102),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 22),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "DY acumado no Ano",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "${getAcumuladoDy().toString()}%",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "DY On Cost acumulado no Ano",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "${getAcumuladoDyOnCost().toStringAsPrecision(2)}%",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
