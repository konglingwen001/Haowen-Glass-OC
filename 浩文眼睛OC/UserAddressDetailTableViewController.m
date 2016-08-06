//
//  UserAddressDetailViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/3.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserAddressDetailTableViewController.h"
#import "Utils.h"
#import "User.h"
#import "Address.h"
#import "AppDelegate.h"

@implementation UserAddressDetailTableViewController

UIPickerView *addressPicker;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *components = [areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    self.address.delegate = self;
    addressPicker = [[UIPickerView alloc] init];
    addressPicker.delegate = self;
    addressPicker.dataSource = self;
    self.address.inputView = addressPicker;
    UIToolbar *accessoryView = [[UIToolbar alloc] init];
    accessoryView.frame=CGRectMake(0, 0, 320, 38);
    accessoryView.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectDoneAction)];
    [doneBtn setTintColor:[UIColor blueColor]];
    UIBarButtonItem *spaceBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    accessoryView.items=@[spaceBtn,doneBtn];
    self.address.inputAccessoryView = accessoryView;
    
}

-(void)viewWillAppear:(BOOL)animated {
    if ([self.type isEqualToString:@"editAddress"]) {
        NSMutableArray *dataArray = [Utils GetUserInfo];
        User *user = [dataArray objectAtIndex:self.userNo];
        NSArray *components = [user.addresses allObjects];
        NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 addressNo] < [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if([obj1 addressNo] > [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        Address *address = [sortedArray objectAtIndex:self.tmpAddressNo];
    
        self.name.text = address.name;
        self.phone.text = address.phone;
        self.address.text = [[address.province stringByAppendingString:address.city] stringByAppendingString:address.district];
        self.detail.text = address.detail;
    } else {
        self.name.text = @"";
        self.phone.text = @"";
        self.address.text = @"";
        self.detail.text = @"";
    }
    
}

- (IBAction)saveAddress:(id)sender {
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    if ([self.type isEqualToString:@"addAddress"]) {
        Address *address = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:context];
        NSInteger provinceRow = [addressPicker selectedRowInComponent:0];
        NSInteger cityRow = [addressPicker selectedRowInComponent:1];
        NSInteger districtRow = [addressPicker selectedRowInComponent:2];
        address.addressNo = [NSNumber numberWithUnsignedLong:[[[user addresses] allObjects] count]];
        address.name = self.name.text;
        address.phone = self.phone.text;
        address.province = [province objectAtIndex:provinceRow];
        address.city = [city objectAtIndex:cityRow];
        address.district = [district objectAtIndex:districtRow];
        address.detail = self.detail.text;
        [user addAddressesObject:address];
        [Utils SaveUserInfo:user AtIndex:self.userNo];
    } else {
        NSArray *components = [user.addresses allObjects];
        NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 addressNo] < [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if([obj1 addressNo] > [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        Address *address = [sortedArray objectAtIndex:self.tmpAddressNo];
        NSInteger provinceRow = [addressPicker selectedRowInComponent:0];
        NSInteger cityRow = [addressPicker selectedRowInComponent:1];
        NSInteger districtRow = [addressPicker selectedRowInComponent:2];
        address.name = self.name.text;
        address.phone = self.phone.text;
        address.province = [province objectAtIndex:provinceRow];
        address.city = [city objectAtIndex:cityRow];
        address.district = [district objectAtIndex:districtRow];
        address.detail = self.detail.text;
        [Utils SaveUserInfo:user AtIndex:self.userNo];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) selectDoneAction {
    [self.address endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [province count];
    } else if (component == 1) {
        return [city count];
    } else {
        return [district count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [province objectAtIndex:row];
    } else if (component == 1) {
        return [city objectAtIndex:row];
    } else {
        return [district objectAtIndex:row];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: [NSString stringWithFormat:@"%ld", (long)row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        city = [[NSArray alloc] initWithArray: array];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        [addressPicker selectRow: 0 inComponent: 1 animated: YES];
        [addressPicker selectRow: 0 inComponent: 2 animated: YES];
        [addressPicker reloadComponent: 1];
        [addressPicker reloadComponent: 2];
    } else if (component == 1) {
        selectedProvince = [province objectAtIndex:[addressPicker selectedRowInComponent:0]];
        NSString *provinceIndex = [NSString stringWithFormat: @"%lu", (unsigned long)[province indexOfObject: selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [addressPicker selectRow: 0 inComponent: 2 animated: YES];
        [addressPicker reloadComponent: 2];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.type isEqualToString:@"editAddress"]) {
        NSMutableArray *dataArray = [Utils GetUserInfo];
        User *user = [dataArray objectAtIndex:self.userNo];
        NSArray *components = [user.addresses allObjects];
        NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 addressNo] < [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if([obj1 addressNo] > [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        Address *address = [sortedArray objectAtIndex:self.tmpAddressNo];
        NSString *currentProvince = [address province];
        NSString *currentCity = [address city];
        NSString *currentDistrict = [address district];
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
        areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        components = [areaDic allKeys];
        sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *tmp = [[areaDic objectForKey: index] allKeys];
            [provinceTmp addObject: [tmp objectAtIndex:0]];
        }
        
        province = [[NSArray alloc] initWithArray: provinceTmp];
        int i = 0;
        for (i = 0; i < [province count]; i++) {
            if ([[province objectAtIndex:i] isEqualToString:currentProvince]) {
                [addressPicker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
        
        NSString *index = [sortedArray objectAtIndex:i];
        NSString *selected = [province objectAtIndex:i];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
        
        NSArray *cityArray = [dic allKeys];
        
        sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        city = [[NSArray alloc] initWithArray: array];
        
        for (i = 0; i < [city count]; i++) {
            if ([[city objectAtIndex:i] isEqualToString:currentCity]) {
                [addressPicker selectRow:i inComponent:1 animated:YES];
                break;
            }
        }
        
        index = [sortedArray objectAtIndex:i];
        selected = [city objectAtIndex: i];
        NSArray *districtArray = [[dic objectForKey:index] objectForKey:selected];
        sortedArray = [districtArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        district = [[NSArray alloc] initWithArray: sortedArray];
        for (i = 0; i < [district count]; i++) {
            if ([[district objectAtIndex:i] isEqualToString:currentDistrict]) {
                [addressPicker selectRow:i inComponent:2 animated:YES];
                break;
            }
        }
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSInteger provinceRow = [addressPicker selectedRowInComponent:0];
    NSInteger cityRow = [addressPicker selectedRowInComponent:1];
    NSInteger districtRow = [addressPicker selectedRowInComponent:2];
    textField.text = [[[province objectAtIndex:provinceRow] stringByAppendingString:[city objectAtIndex:cityRow]] stringByAppendingString:[district objectAtIndex:districtRow]];
}
@end
