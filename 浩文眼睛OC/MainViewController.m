//
//  MainViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/18.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startLocate:(id)sender {
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"开始定位服务");
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1;
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations lastObject];
    self.latitude.text = [NSString stringWithFormat:@"%g", location.coordinate.latitude];
    self.longtitude.text = [NSString stringWithFormat:@"%g", location.coordinate.longitude];
    self.altitude.text = [NSString stringWithFormat:@"%g", location.altitude];
    self.speed.text = [NSString stringWithFormat:@"%g", location.speed];
    self.orientation.text = [NSString stringWithFormat:@"%g", location.course];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
}
- (IBAction)send:(id)sender {
    NSURL *url = [[NSURL alloc]initWithString:@"http://localhost:8080/Test/HelloServlet"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
