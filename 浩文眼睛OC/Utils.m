//
//  Utils.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/19.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "AppDelegate.h"
#import "User.h"

@implementation Utils

ALAssetsLibrary *assets;
NSMutableArray *photoArray;
UIImage *image;

+ (id) GetPhotoWithPhotoLibrary:(NSString *) url {
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    PHFetchResult *f = [PHAsset fetchAssetsWithALAssetURLs:[NSURL URLWithString:url] options:nil];
    
    // 在资源的集合中获取第一个集合，并获取其中的图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    PHAsset *asset = f[0];
    
    [imageManager requestImageForAsset:asset
                            targetSize:CGSizeMake(100, 100)
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             
                             image = result;
                             
                         }];
    return image;
}



+ (id ) GetPhotoWithURL:(NSString *)url {
    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    PHAsset *asset = [allPhotos objectAtIndex:0]; 
    NSMutableArray *array = [[NSMutableArray alloc]init];
    CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSLog(@"%@", result);
        [array addObject:result];
    }];
    
    return [array objectAtIndex:0];
    //return result;
    
//    assets = [[ALAssetsLibrary alloc]init];
//    [assets enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//        if (group) {
//            photoArray = [[Utils alloc] getContentFrom:group withAssetsFilter:[ALAssetsFilter allPhotos]];
//        }
//    } failureBlock:^(NSError *error) {
//        NSLog(@"失败");
//    }];
//    
//    NSURL *ur = [NSURL URLWithString:url];
//    for (NSURL *imageUrl in photoArray) {
//        
//        if ([imageUrl isEqual:ur]) {
//            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//            dispatch_queue_t queue = dispatch_queue_create("sss", DISPATCH_QUEUE_SERIAL);
//            dispatch_async(queue, ^{
//                [assets assetForURL:ur resultBlock:^(ALAsset *asset) {
//                    ALAssetRepresentation *represention = [asset defaultRepresentation];
//                    CGImageRef cgImage = [represention fullScreenImage];
//                    image = [UIImage imageWithCGImage:cgImage];
//                    dispatch_semaphore_signal(sema);
//                } failureBlock:^(NSError *error) {
//                    NSLog(@"失败");
//                    dispatch_semaphore_signal(sema);
//                }];
//            });
//            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//            
//            break;
//        }
//    }
//    return image;
}

-(NSMutableArray *) getContentFrom:(ALAssetsGroup *) group withAssetsFilter:(ALAssetsFilter *) filter {
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    NSMutableArray *contentArray = [[NSMutableArray alloc]init];
    [group setAssetsFilter:filter];
    NSMutableArray *assetsURLDictionaries = [[NSMutableArray alloc]init];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetsURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url = [[result defaultRepresentation]url];
                [contentArray addObject:url];
                [mutableArray addObject:[UIImage imageWithCGImage:[[result defaultRepresentation] fullScreenImage]]];
            }
        }
    }];
    return contentArray;
}

+(id) GetUserInfo {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
        return nil;
    } else {
        return mutableFetchResult;
    }
}

+(void) SaveUserInfo:(User *)user AtIndex:(int)userNo {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError *error = nil;
    NSMutableArray *mutableFetchResult = [[context executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    
    User *tmpUser = [mutableFetchResult objectAtIndex:userNo];
    tmpUser.username = user.username;
    tmpUser.password = user.password;
    tmpUser.nickname = user.nickname;
    tmpUser.email = user.email;
    tmpUser.phone = user.phone;
    tmpUser.userImage = user.userImage;
    if ([context save:&error]) {
        NSLog(@"保存成功");
    }
}

+(void) AddUsers {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    User *user;
    for (int i = 0; i<5; i++) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
        user.username = [NSString stringWithFormat:@"hello%d", i];
        user.password = @"111";
        user.nickname = @"123";
        user.email = @"111";
        user.phone = @"111";
        NSError *error;
        if ([context save:&error]) {
            NSLog(@"保存成功");
        } else {
            NSLog(@"%@, %@", error, [error userInfo]);
        }
    }

}

+(void) ClearUsers {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSMutableArray *dataArray = [self GetUserInfo];
    for (User *user in dataArray) {
        [context deleteObject:user];
    }
    NSError *error;
    [context deletedObjects];
    if ([context save:&error]) {
        NSLog(@"成功");
    }
}

@end
