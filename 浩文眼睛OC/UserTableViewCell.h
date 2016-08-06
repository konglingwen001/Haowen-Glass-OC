//
//  UserTableViewCell.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/6.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *password;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *phone;

@end
