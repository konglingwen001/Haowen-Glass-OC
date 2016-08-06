//
//  UserImageViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/26.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserImageViewController : UIViewController<UIImagePickerControllerDelegate>
@property (assign, nonatomic) int userNo;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;

@end
