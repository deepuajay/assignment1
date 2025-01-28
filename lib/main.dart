import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PayCalculatorScreen(),
    );
  }
}

class PayCalculatorScreen extends StatefulWidget {
  @override
  _PayCalculatorScreenState createState() => _PayCalculatorScreenState();
}

class _PayCalculatorScreenState extends State<PayCalculatorScreen> {
  final TextEditingController hoursInput = TextEditingController();
  final TextEditingController rateInput = TextEditingController();
  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  void calculatePay() {
    final double totalHours = double.tryParse(hoursInput.text) ?? 0.0;
    final double hourlyPay = double.tryParse(rateInput.text) ?? 0.0;

    if (totalHours > 48) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Entry'),
          content: Text('Maximum working is 48 hours.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    if (totalHours <= 40) {
      regularPay = totalHours * hourlyPay;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * hourlyPay;
      overtimePay = (totalHours - 40) * hourlyPay * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay Calculator'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: hoursInput,
              decoration: InputDecoration(
                labelText: 'Total Hours Worked',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: rateInput,
              decoration: InputDecoration(
                labelText: 'Hourly Pay',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculatePay,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text('Calculate Pay', style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 24),
            Text('Regular Pay: \$${regularPay.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            Text('Overtime Pay: \$${overtimePay.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            Text('Total Pay (Before Tax): \$${totalPay.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            Text('Tax (18%): \$${tax.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16)),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Deepu Ajay',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                  Text(
                    'Student ID: 301494114',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
