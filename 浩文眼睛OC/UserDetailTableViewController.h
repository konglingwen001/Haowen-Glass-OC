//
//  UserDetailTableViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/12.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailTableViewController : UITableViewController<UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *lblNickName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblPhoneNum;
@property (assign) int userNo;
@end
