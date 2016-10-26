//
//  RegisterTableViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/9/3.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *lblUsername;
@property (strong, nonatomic) IBOutlet UILabel *lblPassword;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblNickname;
@property (strong, nonatomic) IBOutlet UITextField *tfUsername;
@property (strong, nonatomic) IBOutlet UITextField *tfPassword;
@property (strong, nonatomic) IBOutlet UITextField *tfPhone;
@property (strong, nonatomic) IBOutlet UITextField *tfEmail;
@property (strong, nonatomic) IBOutlet UITextField *tfNickname;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIButton *btnClear;

@end
