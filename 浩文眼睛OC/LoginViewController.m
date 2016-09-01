//
//  LoginViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/5.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "ASIHTTPRequest.h"
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
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/Test/HelloServlet?username=%@&password=%@", self.username.text, self.password.text];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSString *str = [request responseString];
    if ([str isEqualToString:@"Failed"]) {
        NSLog(@"登录失败");
    } else {
        NSLog(@"登录成功");
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated {
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
