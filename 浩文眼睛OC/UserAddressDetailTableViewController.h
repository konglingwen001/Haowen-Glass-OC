//
//  UserAddressDetailViewController.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/3.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserAddressDetailTableViewController : UITableViewController<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

{
    NSArray *pickArray;
    NSDictionary *areaDic;
    NSString *selectedProvince;
    NSArray *province;
    NSArray *city;
    NSArray *district;
}
@property (assign, nonatomic) int userNo;
@property (assign, nonatomic) int tmpAddressNo;
@property (assign, nonatomic) NSString *type;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *detail;

@end
