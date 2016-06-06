//
//  ViewController.h
//  WhetherApp
//
//  Created by Mahaboobsab Nadaf on 04/06/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController




@property (weak, nonatomic) IBOutlet UILabel *feelsLike;


@property (weak, nonatomic) IBOutlet UILabel *cloudCover;

@property (weak, nonatomic) IBOutlet UILabel *humiDity;
@property (weak, nonatomic) IBOutlet UILabel *pressure;

@property (weak, nonatomic) IBOutlet UILabel *observationTime;

@property (weak, nonatomic) IBOutlet UILabel *weatherDesc;

- (IBAction)secondButton:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *changeInObschanceofrain;




@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic)NSDictionary *jsonAPI;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property(strong, nonatomic)NSString *urlString;
@property(strong, nonatomic)NSMutableArray *cityDetails;
@property(strong, nonatomic)NSMutableArray *cityTemp;
@property(strong, nonatomic)NSMutableArray *cityTempImage;
@property(strong, nonatomic)NSMutableArray *cityTempDate;

@property(strong, nonatomic)NSArray *dateCuruent;


@property(strong,nonatomic)NSArray *zerothArray;
@property(strong,nonatomic)NSArray *firstArray;
@property(strong,nonatomic)NSArray *secondArray;

- (IBAction)thirdButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *zerothButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *firstButtonOutlet;

@property (weak, nonatomic) IBOutlet UIButton *secondButtonOutlet;
@end

