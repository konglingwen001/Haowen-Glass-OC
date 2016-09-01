//
//  RegisterViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/5.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "Utils.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *nickname;

@property (nonatomic, weak) AppDelegate *appDelegate;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation RegisterViewController
- (IBAction)submit:(id)sender {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/Test/Register"];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    [request setPostValue:self.username.text forKey:@"username"];
    [request setPostValue:self.password.text forKey:@"password"];
    [request setPostValue:self.phone.text forKey:@"phone"];
    [request setPostValue:self.email.text forKey:@"email"];
    [request setPostValue:self.nickname.text forKey:@"nickname"];
    [request setRequestMethod:@"POST"];
    [request startSynchronous];   
}
- (IBAction)clear:(UIButton *)sender {

    //[Utils ClearUsers];
}
- (IBAction)AddUsers:(id)sender {
    //[Utils AddUsers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"登录错误", nil);
    NSString *message = NSLocalizedString(@"用户名已存在，请重新输入", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.username.text = @"";
        self.password.text = @"";
        self.nickname.text = @"";
        self.email.text = @"";
        self.phone.text = @"";
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
