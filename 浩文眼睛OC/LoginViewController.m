//
//  LoginViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/5.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "LoginViewController.h"
#import "UserTableViewCell.h"
#import "AppDelegate.h"
#import "User.h"
#import "Utils.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation LoginViewController
- (IBAction)login:(UIButton *)sender {
    int count = 0;
    for (User *user in self.dataArray) {
        if ([self.username.text isEqualToString:user.username] && [self.password.text isEqualToString:user.password]) {
            NSLog(@"登录成功");
            break;
        }
        count++;
    }
    if (count >= self.dataArray.count) {
        NSLog(@"登录失败");
    }
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInteger:count], @"index", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"do" object:self userInfo:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated {
    self.dataArray = [Utils GetUserInfo];
    [self.table reloadData];
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
