import 'package:flutter/material.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'image': 'assets/onboarding1.jpg',
      'title': 'Discover Ideas',
      'subtitle': 'Explore and discover creative ideas from around the world.',
    },
    {
      'image': 'assets/onboarding2.jpg',
      'title': 'Save Inspiration',
      'subtitle': 'Save your favorite ideas to boards and organize them.',
    },
    {
      'image': 'assets/onboarding3.jpg',
      'title': 'Get Inspired',
      'subtitle': 'Get inspired by millions of images and ideas.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            controller: _controller,
            itemCount: _onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(
                imageData: _onboardingData[index],
              );
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
          _currentPage == _onboardingData.length - 1
              ? Positioned(
                  bottom: 60.0,
                  right: 20.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the action when the user taps the "Get Started" button
                    },
                    child: Text('Get Started'),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _onboardingData.length; i++) {
      indicators.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final Map<String, String> imageData;

  OnboardingPage({required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imageData['image']!,
            fit: BoxFit.cover,
            height: 300.0,
          ),
          SizedBox(height: 20.0),
          Text(
            imageData['title']!,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            imageData['subtitle']!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
