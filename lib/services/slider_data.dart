import 'package:news_app/models/slider_model.dart';

List<SliderModel> getSlider() {
  List<SliderModel> slider = [];
  SliderModel sliderModel = SliderModel();

  sliderModel.name = "Bonus shares 2023: Shares of Alphalogic Industries Ltd will be in focus when the stock market opens on Friday as its Bonus Issue is scheduled for the day. The company will issue Bonus Share in the ratio of 1:1 which means 1 equity share of ₹10 each for every 1 equity share held to its eligible shareholders.";
  sliderModel.image = "assets/images/b1.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.name = "Rohit Sharma Offered T20 Captaincy But.... Report Hints At India Skipper's Future";
  sliderModel.image = "assets/images/sports.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  sliderModel.name = "Reaching men with person-centred health services through evidence-based approaches and interventions";
  sliderModel.image = "assets/images/health.jpg";
  slider.add(sliderModel);
  sliderModel = SliderModel();

  


  

  return slider;
}