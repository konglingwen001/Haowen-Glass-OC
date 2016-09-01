//
//  Utils.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/19.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "User.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation Utils

+ (Boolean) isLogedIn {
    NSString *urlStr = @"http://localhost:8080/Test/HelloServlet";
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSString *str = [request responseString];
    if ([str isEqualToString:@"Success"]) {
        return YES;
    } else {
        return NO;
    }
}

// 获取地址个数
+(int)GetAddressCount {
    NSString *urlStr = @"http://localhost:8080/Test/GetAddressCount";
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request startSynchronous];
    return [[request responseString] intValue];
}

// 获取地址信息
// 参数"index":所获取地址在所有地址中的位置index
// 返回值：地址dictionary
+ (NSDictionary *) GetAddress:(int)index {
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/Test/GetAddress?index=%d", index];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request startSynchronous];
    NSData *data = [request responseData];
    
    // 将JSON数据转换为dictionary
    NSDictionary *addressDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return addressDic;
    
}

// 保存地址信息
// 参数"addressDic":地址信息(dictionary形式)
+(void)SaveAddress:(NSDictionary *)addressDic {
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/Test/SaveAddress"];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    NSMutableData *data = [NSJSONSerialization dataWithJSONObject:addressDic options:NSJSONWritingPrettyPrinted error:nil].mutableCopy;
    [request setPostBody:data];
    [request startSynchronous];
}

// 保存图片
// 参数"imageUrl":图片文件在沙盒中的地址url
+ (void)SaveImage:(NSString *)imageUrl {
    
    NSString *urlStr = @"http://localhost:8080/Test/SaveImage";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 以文件形式将图片存入服务器
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:url];
    [request setFile:imageUrl forKey:@"testFile"];
    [request startSynchronous];

}

// 获取当前用户的头像图片
+ (id) GetImage {
    NSString *urlStr = @"http://localhost:8080/Test/GetImage";
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    
    [request startSynchronous];
    
    NSData *data = [request responseData];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

// 获取当前用户的个人信息
// 参数"userInfoType":所要获取的个人信息种类（姓名，电话，email等）
// 返回值：获取的个人信息
+ (id) GetUserInfo:(NSString *) userInfoType {
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/Test/GetUserInfo?userInfoType=%@", userInfoType];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSString *result = [request responseString];
    return result;
    
}

// 设定当前用户的个人信息
// 参数:"incoValue":参数值   "userInfoType":参数名
+ (void) SetUserInfo:(NSString *) infoValue forInfoType:(NSString *) userInfoType {
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/Test/SetUserInfo?userInfoType=%@&infoValue=%@", userInfoType, infoValue];
    NSURL *url = [NSURL URLWithString:urlStr];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSString *result = [request responseString];
    if ([result isEqualToString:@"true"]) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
}

@end
