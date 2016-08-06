//
//  NewsViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/20.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface NewsViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
