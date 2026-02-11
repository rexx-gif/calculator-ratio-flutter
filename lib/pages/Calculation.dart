import 'package:flutter/material.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<Calculation> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {

  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController portionController = TextEditingController();

  List <Map<String, TextEditingController>> ingredients = [];
  List <String> result = [];

  @override

  void initState() {
    super.initState();
    addIngredients();
  }

  void addIngredients (){
    if (ingredients.length >= 10) return;
    setState(() {
      ingredients.add({
        "name" : TextEditingController(),
        "amount" : TextEditingController(),
        "unit" : TextEditingController(),
      });
    });
  }

  void calculate (){
    int portion = int.tryParse(portionController.text) ?? 0;
    result.clear();

    for (var item in ingredients) {
      String name = item["name"]!.text;
      double amount = double.tryParse(item["amount"]!.text) ?? 0;
      String unit = item["unit"]!.text;

      double resultAmount = amount * portion;
      result.add("$name: $resultAmount $unit");
    }
    setState(() {
      
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculation Page"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: foodNameController,
              decoration: const InputDecoration(
                labelText: "Nama makanan/minuman",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height:16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bahan (untuk 1 porsi)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height:10),
            Column(
              children: List.generate(ingredients.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ingredients[index]["name"],
                          decoration: const InputDecoration(
                            hintText: "Nama",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      Expanded(
                        child: TextField(
                          controller: ingredients[index]["amount"],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: "Jumlah",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      Expanded(
                        child: TextField(
                          controller: ingredients[index]["unit"],
                          decoration: const InputDecoration(
                            hintText: "Satuan",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 10),

            if (ingredients.length < 10)
              ElevatedButton(
                onPressed: addIngredients,
                child: const Text("Tambah Bahan"),
              ),

            const SizedBox(height: 20),

            TextField(
              controller: portionController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah porsi",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calculate,
              child: const Text("Hitung"),
            ),

            const SizedBox(height: 20),

            if (result.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hasil untuk ${foodNameController.text}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...result.map((e) => Text(e)).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}