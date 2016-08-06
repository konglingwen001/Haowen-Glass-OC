//
//  UserInfoTableViewCell.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/5.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@end
