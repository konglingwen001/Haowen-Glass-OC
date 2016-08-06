//
//  Utils.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/19.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Utils : NSObject

+ (id) GetPhotoWithURL:(NSString *) url;
+ (id) GetPhotoWithPhotoLibrary:(NSString *) url;
+ (id) GetUserInfo;
+ (void) SaveUserInfo:(User *) user AtIndex:(int) userNo;
+(void) AddUsers;
+(void) ClearUsers;

@end
