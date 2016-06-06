//
//  ViewController.m
//  WhetherApp
//
//  Created by Mahaboobsab Nadaf on 04/06/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong,nonatomic)   NSArray *performersArray2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.activityIndicator startAnimating];
    
    
    
    
    self.urlString = [[NSString alloc]init];
     self.urlString = @"http://api.worldweatheronline.com/premium/v1/weather.ashx?key=0494752a675946e292d55629160406&q=Bangalore&format=json&num_of_days=5";
    
    self.performersArray2 = [[NSMutableArray alloc]init];
    
    
    self.jsonAPI = [[NSDictionary alloc]init];
    
    self.cityDetails = [[NSMutableArray alloc]init];
     self.cityTemp = [[NSMutableArray alloc]init];
     self.cityTempImage = [[NSMutableArray alloc]init];
     self.cityTempDate = [[NSMutableArray alloc]init];
    self.dateCuruent = [[NSArray alloc]init];
    
   
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.urlString]completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
        self.jsonAPI = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
     //  NSLog(@"json is : %@",self.jsonAPI);
        
     
        
        NSArray *performersArray = [self.jsonAPI objectForKey:@"data"];
        
        for (NSDictionary *performerDic in [performersArray valueForKey:@"request"]) {
            
            [self.cityDetails addObject:performerDic];
           
        
          //   NSLog(@"Values from self.cityDetails  : %@",self.cityDetails );
            
            
        }
      
        
       
        
          NSArray *secondObject = [performersArray valueForKey:@"weather"];
       // NSLog(@"Second Object is : %@",secondObject);
        self.zerothArray = [secondObject objectAtIndex:0];
        self.firstArray = [secondObject objectAtIndex:1];
        self.secondArray = [secondObject objectAtIndex:2];
        
        NSLog(@"First Arra is : %@",self.firstArray);
        
     // NSLog(@"City is : %@",[self.cityDetails valueForKey:@"query"]);
        
          //current_condition
        for (NSDictionary *performerDic in [performersArray valueForKey:@"current_condition"]) {
            
            [self.cityTemp addObject:performerDic];
            
            
            NSLog(@"Values from current_condition : %@",self.cityTemp );
            
            
        }
        
        for (NSDictionary *performerDic in [performersArray valueForKey:@"weather"]) {
            
            [self.cityTempDate addObject:performerDic];
            
            
           // NSLog(@"Values from date  : %@",self.cityTempDate );
            self.dateCuruent = [self.cityTempDate valueForKey:@"date"];
            
        }
       //  NSLog(@"Values from date  : %@",self.cityTempDate );
       // NSLog(@"Current date is : %@",self.dateCuruent);
        
        
        
        
    }];
    
    [dataTask resume];
    
    
    
    if (self.jsonAPI != nil) {
        
       [NSTimer    scheduledTimerWithTimeInterval:10.0    target:self    selector:@selector(loadData)    userInfo:nil repeats:NO];
       
    }
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getWeather:(id)sender {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
     [NSTimer    scheduledTimerWithTimeInterval:5.0    target:self    selector:@selector(stopAnimation)    userInfo:nil repeats:NO];
    
    self.changeInObschanceofrain.text = @"Chance Of Rain";
    
    NSArray *temp = [self.cityDetails valueForKey:@"query"];
    
    self.cityLabel.text = [NSString stringWithFormat:@"%@",temp[0]];
    
    NSArray *tempDate = [self.zerothArray valueForKey:@"date"];
    
    NSLog(@"Second Button Date is : %@",tempDate);
    
    self.dateLabel.text =[NSString stringWithFormat:@"%@",tempDate];
    
    //maxtempC
    
    NSArray *tempMax = [self.zerothArray valueForKey:@"maxtempC"];
    
    NSLog(@"Second Button maxtempC is : %@",tempMax);
    
    self.tempLabel.text =[NSString stringWithFormat:@"+%@°C",tempMax];
    
    //Image hourly
    NSArray *tempImage = [self.zerothArray valueForKey:@"hourly"];
    
    tempImage = [tempImage valueForKey:@"weatherIconUrl"];
    
    tempImage = [tempImage objectAtIndex:0];
    tempImage = [tempImage objectAtIndex:0];
    
    tempImage = [tempImage valueForKey:@"value"];
    
    NSString *url = [NSString stringWithFormat:@"%@",tempImage];
    NSString *ImageURL = url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    self.tempImageView.image = [UIImage imageWithData:imageData];
    
    NSLog(@"Second Image maxtempC is : %@",tempImage);
    
    //weatherDesc
    NSArray *tempWeatherDesc = [self.zerothArray valueForKey:@"hourly"];
    
    tempWeatherDesc = [tempWeatherDesc valueForKey:@"weatherDesc"];
    
    tempWeatherDesc = [tempWeatherDesc valueForKey:@"value"];
    tempWeatherDesc = [tempWeatherDesc objectAtIndex:0];
    tempWeatherDesc = [tempWeatherDesc objectAtIndex:0];
    
    self.weatherDesc.text = [NSString stringWithFormat:@"It's %@ ...",tempWeatherDesc];
    // NSLog(@"Temp weather Descr : %@",tempWeatherDesc);
    
    //humidity
    NSArray *tempHumidity = [self.zerothArray valueForKey:@"hourly"];
    
    tempHumidity = [tempHumidity valueForKey:@"humidity"];
    tempHumidity = [tempHumidity objectAtIndex:0];
    self.humiDity.text = [NSString stringWithFormat:@"%@%%",tempHumidity];
    //  NSLog(@"Temp Humidity : %@",tempHumidity);
    
    //pressure
    
    NSArray *tempPressure = [self.zerothArray valueForKey:@"hourly"];
    tempPressure = [tempPressure valueForKey:@"pressure"];
    tempPressure = [tempPressure objectAtIndex:0];
    self.pressure.text = [NSString stringWithFormat:@"%@ hPa",tempPressure];
    // NSLog(@"Temp pressure : %@",tempPressure);
    
    //cloudcover
    NSArray *tempCloudcover = [self.zerothArray valueForKey:@"hourly"];
    tempCloudcover = [tempCloudcover valueForKey:@"cloudcover"];
    tempCloudcover = [tempCloudcover objectAtIndex:0];
    
    self.cloudCover.text = [NSString stringWithFormat:@"%@",tempCloudcover];
    NSLog(@"Temp cloudCover : %@",tempCloudcover);
    
    //FeelsLikeC
    NSArray *tempFeelsLikeC = [self.zerothArray valueForKey:@"hourly"];
    tempFeelsLikeC = [tempFeelsLikeC valueForKey:@"FeelsLikeC"];
    tempFeelsLikeC = [tempFeelsLikeC objectAtIndex:0];
    NSLog(@"Temp tempFeelsLikeC : %@",tempFeelsLikeC);
    self.feelsLike.text = [NSString stringWithFormat:@"+%@°C",tempFeelsLikeC];
  
    
   // [self.zerothButtonOutlet setTitle:[NSString stringWithFormat:@"+%@°C",tempFeelsLikeC] forState:UIControlStateNormal];
    
    //chanceofrain
    NSArray *tempChanceofrain = [self.zerothArray valueForKey:@"hourly"];
    tempChanceofrain = [tempChanceofrain valueForKey:@"chanceofrain"];
    tempChanceofrain = [tempChanceofrain objectAtIndex:0];
    NSLog(@"Temp tempChanceofrain : %@",tempChanceofrain);
    self.observationTime.text = [NSString stringWithFormat:@"%@",tempChanceofrain];
    
   
}













- (IBAction)secondButton:(id)sender {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
     [NSTimer    scheduledTimerWithTimeInterval:5.0    target:self    selector:@selector(stopAnimation)    userInfo:nil repeats:NO];
    
    self.changeInObschanceofrain.text = @"Chance Of Rain";
    
      NSArray *temp = [self.cityDetails valueForKey:@"query"];
    
      self.cityLabel.text = [NSString stringWithFormat:@"%@",temp[0]];
    
    NSArray *tempDate = [self.firstArray valueForKey:@"date"];
    
    NSLog(@"Second Button Date is : %@",tempDate);
    
    self.dateLabel.text =[NSString stringWithFormat:@"%@",tempDate];
    
    //maxtempC
    
    NSArray *tempMax = [self.firstArray valueForKey:@"maxtempC"];
    
    NSLog(@"Second Button maxtempC is : %@",tempMax);
    
    self.tempLabel.text =[NSString stringWithFormat:@"+%@°C",tempMax];
    
    //Image hourly
    NSArray *tempImage = [self.firstArray valueForKey:@"hourly"];
    
    tempImage = [tempImage valueForKey:@"weatherIconUrl"];
    
    tempImage = [tempImage objectAtIndex:0];
     tempImage = [tempImage objectAtIndex:0];
    
     tempImage = [tempImage valueForKey:@"value"];
    
    NSString *url = [NSString stringWithFormat:@"%@",tempImage];
    NSString *ImageURL = url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    self.tempImageView.image = [UIImage imageWithData:imageData];

    NSLog(@"Second Image maxtempC is : %@",tempImage);
    
    //weatherDesc
    NSArray *tempWeatherDesc = [self.firstArray valueForKey:@"hourly"];
    
    tempWeatherDesc = [tempWeatherDesc valueForKey:@"weatherDesc"];
    
    tempWeatherDesc = [tempWeatherDesc valueForKey:@"value"];
    tempWeatherDesc = [tempWeatherDesc objectAtIndex:0];
     tempWeatherDesc = [tempWeatherDesc objectAtIndex:0];
    
    self.weatherDesc.text = [NSString stringWithFormat:@"It's %@ ...",tempWeatherDesc];
   // NSLog(@"Temp weather Descr : %@",tempWeatherDesc);
    
    //humidity
    NSArray *tempHumidity = [self.firstArray valueForKey:@"hourly"];
    
    tempHumidity = [tempHumidity valueForKey:@"humidity"];
    tempHumidity = [tempHumidity objectAtIndex:0];
    self.humiDity.text = [NSString stringWithFormat:@"%@%%",tempHumidity];
  //  NSLog(@"Temp Humidity : %@",tempHumidity);
    
    //pressure
    
      NSArray *tempPressure = [self.firstArray valueForKey:@"hourly"];
     tempPressure = [tempPressure valueForKey:@"pressure"];
     tempPressure = [tempPressure objectAtIndex:0];
    self.pressure.text = [NSString stringWithFormat:@"%@ hPa",tempPressure];
   // NSLog(@"Temp pressure : %@",tempPressure);
    
    //cloudcover
    NSArray *tempCloudcover = [self.firstArray valueForKey:@"hourly"];
    tempCloudcover = [tempCloudcover valueForKey:@"cloudcover"];
    tempCloudcover = [tempCloudcover objectAtIndex:0];

    self.cloudCover.text = [NSString stringWithFormat:@"%@",tempCloudcover];
    NSLog(@"Temp cloudCover : %@",tempCloudcover);
    
    //FeelsLikeC
    NSArray *tempFeelsLikeC = [self.firstArray valueForKey:@"hourly"];
    tempFeelsLikeC = [tempFeelsLikeC valueForKey:@"FeelsLikeC"];
    tempFeelsLikeC = [tempFeelsLikeC objectAtIndex:0];
     NSLog(@"Temp tempFeelsLikeC : %@",tempFeelsLikeC);
    self.feelsLike.text = [NSString stringWithFormat:@"+%@°C",tempFeelsLikeC];
    
   // [self.firstButtonOutlet setTitle:[NSString stringWithFormat:@"+%@°C",tempFeelsLikeC] forState:UIControlStateNormal];
    
    
    //chanceofrain
    NSArray *tempChanceofrain = [self.firstArray valueForKey:@"hourly"];
    tempChanceofrain = [tempChanceofrain valueForKey:@"chanceofrain"];
    tempChanceofrain = [tempChanceofrain objectAtIndex:0];
    NSLog(@"Temp tempChanceofrain : %@",tempChanceofrain);
    self.observationTime.text = [NSString stringWithFormat:@"%@",tempChanceofrain];
    

    
}


- (IBAction)thirdButton:(id)sender {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
    [NSTimer    scheduledTimerWithTimeInterval:5.0    target:self    selector:@selector(stopAnimation)    userInfo:nil repeats:NO];
    
    self.changeInObschanceofrain.text = @"Chance Of Rain";
    
    NSArray *temp = [self.cityDetails valueForKey:@"query"];
    
    self.cityLabel.text = [NSString stringWithFormat:@"%@",temp[0]];
    
    NSArray *tempDate = [self.secondArray valueForKey:@"date"];
    
    NSLog(@"Second Button Date is : %@",tempDate);
    
    self.dateLabel.text =[NSString stringWithFormat:@"%@",tempDate];
    
    //maxtempC
    
    NSArray *tempMax = [self.secondArray valueForKey:@"maxtempC"];
    
    NSLog(@"Second Button maxtempC is : %@",tempMax);
    
    self.tempLabel.text =[NSString stringWithFormat:@"+%@°C",tempMax];
    
    //Image hourly
    NSArray *tempImage = [self.secondArray valueForKey:@"hourly"];
    
    tempImage = [tempImage valueForKey:@"weatherIconUrl"];
    
    tempImage = [tempImage objectAtIndex:0];
    tempImage = [tempImage objectAtIndex:0];
    
    tempImage = [tempImage valueForKey:@"value"];
    
    NSString *url = [NSString stringWithFormat:@"%@",tempImage];
    NSString *ImageURL = url;
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    self.tempImageView.image = [UIImage imageWithData:imageData];
    
    NSLog(@"Second Image maxtempC is : %@",tempImage);
    
    //weatherDesc
    NSArray *tempWeatherDesc = [self.secondArray valueForKey:@"hourly"];
    
    tempWeatherDesc = [tempWeatherDesc valueForKey:@"weatherDesc"];
    
    tempWeatherDesc = [tempWeatherDesc valueForKey:@"value"];
    tempWeatherDesc = [tempWeatherDesc objectAtIndex:0];
    tempWeatherDesc = [tempWeatherDesc objectAtIndex:0];
    
    self.weatherDesc.text = [NSString stringWithFormat:@"It's %@ ...",tempWeatherDesc];
    // NSLog(@"Temp weather Descr : %@",tempWeatherDesc);
    
    //humidity
    NSArray *tempHumidity = [self.firstArray valueForKey:@"hourly"];
    
    tempHumidity = [tempHumidity valueForKey:@"humidity"];
    tempHumidity = [tempHumidity objectAtIndex:0];
    self.humiDity.text = [NSString stringWithFormat:@"%@%%",tempHumidity];
    //  NSLog(@"Temp Humidity : %@",tempHumidity);
    
    //pressure
    
    NSArray *tempPressure = [self.secondArray valueForKey:@"hourly"];
    tempPressure = [tempPressure valueForKey:@"pressure"];
    tempPressure = [tempPressure objectAtIndex:0];
    self.pressure.text = [NSString stringWithFormat:@"%@ hPa",tempPressure];
    // NSLog(@"Temp pressure : %@",tempPressure);
    
    //cloudcover
    NSArray *tempCloudcover = [self.secondArray valueForKey:@"hourly"];
    tempCloudcover = [tempCloudcover valueForKey:@"cloudcover"];
    tempCloudcover = [tempCloudcover objectAtIndex:0];
    
    self.cloudCover.text = [NSString stringWithFormat:@"%@",tempCloudcover];
    NSLog(@"Temp cloudCover : %@",tempCloudcover);
    
    //FeelsLikeC
    NSArray *tempFeelsLikeC = [self.secondArray valueForKey:@"hourly"];
    tempFeelsLikeC = [tempFeelsLikeC valueForKey:@"FeelsLikeC"];
    tempFeelsLikeC = [tempFeelsLikeC objectAtIndex:0];
    NSLog(@"Temp tempFeelsLikeC : %@",tempFeelsLikeC);
    self.feelsLike.text = [NSString stringWithFormat:@"+%@°C",tempFeelsLikeC];
    
   // [self.secondButtonOutlet setTitle:[NSString stringWithFormat:@"+%@°C",tempFeelsLikeC] forState:UIControlStateNormal];
    
    //chanceofrain
    NSArray *tempChanceofrain = [self.secondArray valueForKey:@"hourly"];
    tempChanceofrain = [tempChanceofrain valueForKey:@"chanceofrain"];
    tempChanceofrain = [tempChanceofrain objectAtIndex:0];
    NSLog(@"Temp tempChanceofrain : %@",tempChanceofrain);
    self.observationTime.text = [NSString stringWithFormat:@"%@",tempChanceofrain];

   
}

-(void)loadData{
    
    self.activityIndicator.hidden = YES;
        NSArray *temp = [self.cityDetails valueForKey:@"query"];
        NSArray *tempForTemp = [self.cityTemp valueForKey:@"temp_C"];
        NSArray *tmpDate = [self.cityTempDate valueForKey:@"date"];
    
        NSArray *feelsLike = [self.cityTemp valueForKey:@"FeelsLikeC"];
        NSArray *cloudCover = [self.cityTemp valueForKey:@"cloudcover"];
    
        NSArray *himidity = [self.cityTemp valueForKey:@"humidity"];
        NSArray *pressure = [self.cityTemp valueForKey:@"pressure"];
        NSArray *observationTime = [self.cityTemp valueForKey:@"observation_time"];
    
        NSArray *weatherDescObj = [self.cityTemp valueForKey:@"weatherDesc"];
    
    
    
    
        //NSLog(@"Weather Desc : %@",weatherDes[0]);
    
    
    
    
    
        NSLog(@"Temp Date date : %@",tmpDate);
        //Set Image
        NSArray *tempForTempImage = [self.cityTemp valueForKey:@"weatherIconUrl"];
    
        NSArray *imageUrl = [tempForTempImage valueForKey:@"value"];
        NSArray *weatherDes = [weatherDescObj valueForKey:@"value"];
    
        imageUrl = [imageUrl objectAtIndex:0];
        weatherDes = [weatherDes objectAtIndex:0];
    
        //   NSLog(@"imageUrl is at 0: %@",imageUrl);
    
        NSString *finalStr = [imageUrl objectAtIndex:0];
        // NSLog(@"Final Str : %@",finalStr);
    
        NSString *finalWeather = [weatherDes objectAtIndex:0];
        NSString *url = finalStr;
    
    
        self.cityLabel.text = [NSString stringWithFormat:@"%@",temp[0]];
        self.tempLabel.text = [NSString stringWithFormat:@"+%@°C",tempForTemp[0]];
    
    
        self.feelsLike.text = [NSString stringWithFormat:@"+%@°C",feelsLike[0]];
        self.cloudCover.text = [NSString stringWithFormat:@"%@",cloudCover[0]];
        self.humiDity.text = [NSString stringWithFormat:@"%@%%",himidity[0]];
        self.pressure.text = [NSString stringWithFormat:@"%@ hPa",pressure[0]];
        self.observationTime.text = [NSString stringWithFormat:@"%@",observationTime[0]];
        self.weatherDesc.text = [NSString stringWithFormat:@"It's %@ ...",finalWeather];
    
    
        self.dateLabel.text = [self.dateCuruent objectAtIndex:0];
        NSString *ImageURL = url;
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        self.tempImageView.image = [UIImage imageWithData:imageData];
    
    
    //FeelsLikeC
    NSArray *tempFeelsLikeC = [self.zerothArray valueForKey:@"maxtempC"];
    NSLog(@"Temp tempFeelsLikeC : %@",tempFeelsLikeC);
    
    [self.zerothButtonOutlet setTitle:[NSString stringWithFormat:@"+%@°C",tempFeelsLikeC] forState:UIControlStateNormal];
    
    
    //FeelsLikeCC
    NSArray *tempFeelsLikeCC = [self.firstArray valueForKey:@"maxtempC"];
    NSLog(@"Temp tempFeelsLikeCC : %@",tempFeelsLikeCC);
    
    [self.firstButtonOutlet setTitle:[NSString stringWithFormat:@"+%@°C",tempFeelsLikeCC] forState:UIControlStateNormal];
    
    
    //FeelsLikeCCC
    NSArray *tempFeelsLikeCCC = [self.secondArray valueForKey:@"maxtempC"];
    NSLog(@"Temp tempFeelsLikeCCC : %@",tempFeelsLikeCCC);
    
    [self.secondButtonOutlet setTitle:[NSString stringWithFormat:@"+%@°C",tempFeelsLikeCCC] forState:UIControlStateNormal];
    
        [self.activityIndicator stopAnimating];

}

-(void)stopAnimation{

    self.activityIndicator.hidden = YES;
    [self.activityIndicator stopAnimating];
}
@end
