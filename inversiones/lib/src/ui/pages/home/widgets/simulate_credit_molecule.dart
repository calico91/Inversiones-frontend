import 'package:flutter/widgets.dart';

class SimulateCreditMolecule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Column(
                  children: [
                    const Text("Simular credito"),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Cantidad',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Cuotas',
                            ),
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Interes',
                            ),
                          ),
                          FilledButton(
                            onPressed: () {},
                            child: const Text('Calcular'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
  }
  
}