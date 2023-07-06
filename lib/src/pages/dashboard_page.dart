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
  var anoAtual = true;

  @override
  void initState() {
    initDividend();
    super.initState();
  }

  void initDividend() async {
    _dividends = await dividendYieldRepository.listarDy(anoAtual);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerCustom(),
      appBar: AppBar(
        title: const Text("Pagina Inicial"),
        actions: [
          if (_dividends.length >= 5)
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
      floatingActionButton: _dividends.length < 5
          ? FloatingActionButton.extended(
              backgroundColor: Colors.grey[850],
              label: const Text("Adicionar DY"),
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalcularDY(),
                  ),
                );
              },
            )
          : const Text(""),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: const Color.fromARGB(255, 102, 102, 102),
              width: double.infinity,
              height: 40,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    Text("Ano Atual",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: SizedBox(
                height: 600,
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
                                    height: 40,
                                    color: const Color.fromARGB(
                                        255, 102, 102, 102),
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
                                            dy.mes,
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
                                      dy.dy.toString(),
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
                                      dy.dyOnCost.toString(),
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
                                      dy.valorAplicado.toString(),
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
                                      dy.valorBruto.toString(),
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
                                      dy.rentabilidadeNoMes.toString(),
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
              margin: const EdgeInsets.all(4),
              child: const Card(
                color: Colors.black45,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Acumado no Ano",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "12,91%",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
