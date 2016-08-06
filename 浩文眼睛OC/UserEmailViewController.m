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
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    self.email.text = user.email;
}
- (IBAction)save:(id)sender {
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    user.email = self.email.text;
    [Utils SaveUserInfo:user AtIndex:self.userNo];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
