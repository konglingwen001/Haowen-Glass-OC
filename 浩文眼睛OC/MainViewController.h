//
//  MainViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/18.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longtitude;
@property (strong, nonatomic) IBOutlet UILabel *altitude;
@property (strong, nonatomic) IBOutlet UILabel *speed;
@property (strong, nonatomic) IBOutlet UILabel *orientation;
@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UILabel *testText;
@property (strong, nonatomic) IBOutlet UIButton *testBtn;

@end
