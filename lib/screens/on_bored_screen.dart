import 'package:flutter/material.dart';
import 'package:green_bin/screens/login/login_screen.dart';
import 'package:green_bin/shared/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboredModel {
  final String image;
  final String text;

  OnboredModel({
    required this.image,
    required this.text,
  });
}

class OnBoredScreen extends StatefulWidget {
  // const OnBoredScreen({Key? key}) : super(key: key);

  @override
  State<OnBoredScreen> createState() => _OnBoredScreenState();
}

class _OnBoredScreenState extends State<OnBoredScreen> {
  var onboredController = PageController();

  List onboreding = [
    OnboredModel(
      image: 'assets/images/onBored1.png',
      text:
          'Separate The Waste You HAve At Home, Enter Their Types And Numbers Start Collecting Points  ',
    ),
    OnboredModel(
      image: 'assets/images/onBored2.png',
      text: 'We Send A Cleaner To Your House To Take Your Waste For Free  ',
    ),
    OnboredModel(
      image: 'assets/images/onBored3.png',
      text: 'With Green Bin We Will Take Care Of The Environment ',
    ),
  ];

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //    appBar: AppBar(),
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: PageView.builder(
                itemBuilder: (context, index) =>
                    buildOnBoredItem(onboreding[index]),
                itemCount: onboreding.length,
                physics: const BouncingScrollPhysics(),
                controller: onboredController,
                onPageChanged: (value) {
                  if (value == onboreding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: onboredController,
            count: onboreding.length,
            effect: const WormEffect(
              dotColor: Colors.grey,
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Colors.greenAccent,
              strokeWidth: 40,
              // offset: 10,
              spacing: 8,
            ),
          ),
          const SizedBox(height: 35),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'SKIP',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                ),
              ),
              Spacer(),
              // FloatingActionButton(
              //   onPressed: () {},
              // ),
              FlatButton(
                onPressed: () {
                  if (isLast) {
                    onboredController.nextPage(
                      duration: Duration(milliseconds: 900),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                    CacheHellper.setData(key: 'onbordeing', value: true)
                        .then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                      }
                    });
                  } else {
                    onboredController.nextPage(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  }
                },
                minWidth: 10,
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isLast)
                      Text(
                        'Get Started',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                      ),
                    const SizedBox(width: 8),
                    Icon(
                      isLast
                          ? Icons.arrow_forward_rounded
                          : Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
                color: Colors.greenAccent[700],
              )
            ],
          ),
        ],
      ),
    ));
  }

  Widget buildOnBoredItem(OnboredModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('body '),
          Image(
            image: AssetImage('${model.image}'),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '${model.text}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14.68,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      );
}
