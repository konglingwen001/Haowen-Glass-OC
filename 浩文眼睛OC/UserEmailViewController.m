//
//  UserEmailViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/29.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserEmailViewController.h"
#import "Utils.h"
#import "User.h"

@implementation UserEmailViewController

-(void)viewDidLoad {
    self.email.text = [Utils GetUserInfo:@"email"];
}
- (IBAction)save:(id)sender {
    [Utils SetUserInfo:self.email.text forInfoType:@"email"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
