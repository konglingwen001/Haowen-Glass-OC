//
//  NewsViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/20.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.rotateEnabled = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self locateToLatitude:23.126272 longitude:113.395568];
}

- (void) locateToLatitude:(CGFloat) latitude longitude:(CGFloat) longitude {
    CLLocationCoordinate2D center = {latitude, longitude};
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    MKCoordinateRegion region = {center, span};
    [self.mapView setRegion:region];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
