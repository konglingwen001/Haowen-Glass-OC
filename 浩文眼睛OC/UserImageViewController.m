//
//  UserImageViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/26.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserImageViewController.h"
#import "Utils.h"
#import "User.h"

@implementation UserImageViewController

-(void)viewWillAppear:(BOOL)animated {
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    if (user.userImage == nil) {
        self.userImage.image = nil;
    } else {
        self.userImage.image = [Utils GetPhotoWithURL:user.userImage];
    }
}
- (IBAction)imageSelect:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSURL *url = [info valueForKey:UIImagePickerControllerReferenceURL];
    NSString *str = [url absoluteString];
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    user.userImage = str;
    [Utils SaveUserInfo:user AtIndex:self.userNo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] != YES) {
        NSLog(@"相机不可用");
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}
@end
