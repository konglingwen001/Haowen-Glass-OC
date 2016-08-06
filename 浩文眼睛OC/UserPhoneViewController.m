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
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    self.phone.text = user.phone;
}
- (IBAction)save:(id)sender {
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    user.phone = self.phone.text;
    [Utils SaveUserInfo:user AtIndex:self.userNo];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
