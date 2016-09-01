//
//  UserNickNameViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/29.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserNickNameViewController.h"
#import "Utils.h"

@implementation UserNickNameViewController

-(void)viewDidLoad {
    self.nickname.text = [Utils GetUserInfo:@"nickname"];
}
- (IBAction)save:(id)sender {
    [Utils SetUserInfo:self.nickname.text forInfoType:@"nickname"];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
