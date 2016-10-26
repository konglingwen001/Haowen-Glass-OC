//
//  LoginTableViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/9/17.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnRegiste;

@end
