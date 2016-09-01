//
//  UserPhoneViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/29.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserPhoneViewController.h"
#import "Utils.h"
#import "User.h"

@implementation UserPhoneViewController

-(void)viewDidLoad {
    self.phone.text = [Utils GetUserInfo:@"phone"];
}
- (IBAction)save:(id)sender {
    [Utils SetUserInfo:self.phone.text forInfoType:@"phone"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
