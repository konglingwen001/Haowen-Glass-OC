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
+ (Boolean) isLogedIn;
+ (int) GetAddressCount;
+ (NSDictionary *) GetAddress:(int) index;
+ (void) SaveAddress:(NSDictionary *) addressDic;
+ (void) SaveImage:(NSString *) imageUrl;
+ (id) GetImage;
+ (id) GetUserInfo:(NSString *) userInfoType;
+ (void) SetUserInfo:(NSString *) nickname forInfoType:(NSString *) userInfoType;

@end
