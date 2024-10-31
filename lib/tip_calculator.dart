import 'package:flutter/material.dart';

class TipCalculatorPage extends StatefulWidget {
  const TipCalculatorPage({super.key});

  @override
  State<TipCalculatorPage> createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage> {
  double billAmount = 0;
  int split = 1;
  double tipPercentage = 0;
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        backgroundColor: Colors.green.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Total Per Person
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Per Person\n\$${calculateTotalPerPerson().toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Bill Amount
            TextField(
              cursorColor: Colors.green.shade100,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: 'Bill Amount',
              ),
              onChanged: (value) {
                setState(() {
                  billAmount = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 16),
            // Split
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (split > 1) {
                        split--;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove),
                ),
                Text(split.toString()),
                IconButton(
                  onPressed: () {
                    setState(() {
                      split++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Tip
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: tipPercentage,
                    min: 0.0,
                    max: 0.3,
                    divisions: 6,
                    thumbColor: Colors.green.shade100,
                    activeColor: Colors.green.shade100,
                    onChanged: (value) {
                      setState(() {
                        tipPercentage = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Text('${(tipPercentage * 100).toStringAsFixed(0)}%'),
              ],
            ),
            const SizedBox(height: 16),
            // Tip Amount
            Text(
              'Tip: \$${calculateTip().toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Total Amount: \$${totalsAmount().toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPerPerson() {
    return (billAmount + calculateTip()) / split;
  }

  double calculateTip() {
    return billAmount * tipPercentage;
  }

  double totalsAmount() {
    return billAmount + calculateTip();
  }
}
