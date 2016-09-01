//
//  UserImageViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/26.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserImageViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Utils.h"
#import "User.h"

@implementation UserImageViewController

-(void)viewWillAppear:(BOOL)animated {
    self.userImage.image = [Utils GetImage];
}
- (IBAction)imageSelect:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 获取相册中的图片数据
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSData *data = UIImagePNGRepresentation(image);
    
    // 将获取的图片数据存入沙盒，临时保存
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *newPath = [path stringByAppendingPathComponent:@"test.jpg"];
    [data writeToFile:newPath atomically:YES];
    
    // 将沙盒中的图片通过路径保存到数据库
    [Utils SaveImage:newPath];
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
