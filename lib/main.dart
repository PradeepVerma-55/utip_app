import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTip App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
   int _personCount = 1;

  //Method to increment person count
  void increment(){
    setState(() {
      _personCount= _personCount + 1;
    });
  }
  // Method to decrement person count

  void decrement(){
    setState(() {
      if(_personCount>0){
        _personCount= _personCount - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('UTip')),
      // Add padding around the page so content is inset from the screen edges.
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12), // inner spacing for texts
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text('Total Per Person!', style: style),
                  SizedBox(height: 8),
                  Text(
                    "\$ 23.78",
                    style: style.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontSize: theme.textTheme.displaySmall?.fontSize,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money),
                      labelText: 'Bill Amount',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      // Handle bill amount change
                     
                    },
                  ),
                  //Split the bill Area
                  SizedBox(height: 16),
                  PersonCounter(theme: theme, personCount: _personCount, onIncrement:increment , onDecrement: decrement),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonCounter extends StatelessWidget {
  const PersonCounter({
    super.key,
    required this.theme,
    required int personCount, required this.onIncrement, required this.onDecrement,
  }) : _personCount = personCount;

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  final ThemeData theme;
  final int _personCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Split", style: theme.textTheme.titleMedium),
        Row(
          children: [
            IconButton(
              color: theme.colorScheme.primary,
              onPressed: onDecrement,
              icon: const Icon(Icons.remove),
            ),
            Text("$_personCount", style: theme.textTheme.titleMedium),
            IconButton(
              color: theme.colorScheme.primary,
              onPressed: onIncrement,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
