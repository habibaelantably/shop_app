
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Network/local/cacheHelper.dart';
import 'package:shop_app/components/reusable_components.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel
{
  final String? image;
  final String? title;
  final String? body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
void onSubmite(context)
{
  cacheHelper.saveData(key: 'OnBoarding', value: true).then((value)
  {
    if(value)
    {
      NavigateAndKill(context,LoginScreen());
    }
  });
}

class OnBoardingScreen extends StatefulWidget

{
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller=PageController();

  List<OnBoardingModel>boarding=[
    OnBoardingModel(image: 'assets/images/account.jpg', title: 'Sign up/in', body: 'Sign up and login to your account to see discounts and buy online'),
    OnBoardingModel(image: 'assets/images/E-commerce_website4.jpg', title: 'online shoping', body: 'see the newest items and buy from your house'),
    OnBoardingModel(image: 'assets/images/shoponline.jpg', title: 'save money', body: 'shop for all family and save more money by getting offers and discounts'),
  ];



  bool islast=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            onSubmite(context);
          },
              child:Text('Skip')

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                  itemBuilder: (context,index)=>buildIndicatorItem(boarding[index]),
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == boarding.length-1){
                    setState(() {
                      islast=true;
                    });
                  }else{
                    setState(() {
                      islast=false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count:  boarding.length,
                  axisDirection: Axis.horizontal,
                  effect:  SlideEffect(
                      spacing:  5.0,
                      dotWidth:  10.0,
                      dotHeight:  10.0,
                      dotColor:  Colors.grey,
                      activeDotColor: deafultColor
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(islast){
                      onSubmite(context);
                    }else
                      {
                        controller.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                  },
                  child: Icon(
                    Icons.arrow_forward
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget buildIndicatorItem(OnBoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight:FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 15.0,
          fontWeight:FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}

