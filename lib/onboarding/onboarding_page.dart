import 'package:calculator_ratio/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:calculator_ratio/pages/Calculation.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  int currIndex = 0;

  final List<Map<String, String>> slides = [
    {
      "header": "Welcome",
      "title": "to Calculator Ratio",
      "footer": "Your",
      "subtitle": "ultimate ratio calculator app",
    },
    {
      "header": "",
      "title": "Easy to Use",
      "subtitle": "Calculate ratios quickly and easily",
    },
    {
      "header": "",
      "title": "Get Started Now",
      "subtitle": "Let's begin your journey with Calculator Ratio",
    },
  ];

  void nextPage() {
    if (currIndex < slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void prevPage() {
    if (currIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_page.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() => currIndex = index);
                },
                itemBuilder: (context, index) {
                  final slide = slides[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (slide['header']!.isNotEmpty)
                          Text(
                            slide['header']!,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        const SizedBox(height: 8),

                        Text(
                          slide['title']!,
                          style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        if (slide.containsKey('footer')) ...[
                          const SizedBox(height: 8),
                          Text(
                            slide['footer']!,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],

                        const SizedBox(height: 8),

                        Text(
                          slide['subtitle']!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => Container(
                  margin: const EdgeInsets.all(4),
                  width: currIndex == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        currIndex == index ? Colors.blue : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON AREA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  if (currIndex > 0)
                    TextButton(
                      onPressed: prevPage,
                      child: const Text("Back"),
                    ),

                  const Spacer(),

                  ElevatedButton(
                    onPressed: () {
                      if (currIndex == slides.length - 1) {
                        Calculation();
                      } else {
                        nextPage();
                      }
                    },
                    child: Text(
                      currIndex == slides.length - 1
                          ? "Get Started"
                          : "Next",
                    ),
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