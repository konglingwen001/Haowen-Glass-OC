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
    
    // 从area.plist获取省市县信息，存储在Dictionary中
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
    
    // 获取省信息
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[sortedArray count]; i++) {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[areaDic objectForKey: index] allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    province = [[NSArray alloc] initWithArray: provinceTmp];
    
    // 获取市信息
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [province objectAtIndex:0];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[areaDic objectForKey:index]objectForKey:selected]];
    NSArray *cityArray = [dic allKeys];
    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
    
    // 获取区县信息
    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
    
    // textview和Pickerview代理和数据源设定
    self.address.delegate = self;
    addressPicker = [[UIPickerView alloc] init];
    addressPicker.delegate = self;
    addressPicker.dataSource = self;
    self.address.inputView = addressPicker;
    
    // barbutton设定
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
    // 编辑地址进入
    if ([self.type isEqualToString:@"editAddress"]) {
        // 根据地址编号获取地址信息
        NSDictionary *addressDic = [Utils GetAddress:self.AddressIndex];
        self.name.text = [addressDic valueForKey:@"name"];
        self.phone.text = [addressDic valueForKey:@"phone"];
        NSString *address = [[[addressDic valueForKey:@"province"] stringByAppendingString:[addressDic valueForKey:@"city"]] stringByAppendingString:[addressDic valueForKey:@"district"]];
        self.address.text = address;
        self.detail.text = [addressDic valueForKey:@"detail"];
    // 添加地址进入
    } else {
        self.name.text = @"";
        self.phone.text = @"";
        self.address.text = @"";
        self.detail.text = @"";
    }
    
}

- (IBAction)saveAddress:(id)sender {
    
    // 从area.plist获取省市县信息，存储在Dictionary中
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
    long provinceIndex = [addressPicker selectedRowInComponent:0];
    NSString *currentProvince = [province objectAtIndex:provinceIndex];
    
    NSString *index = [sortedArray objectAtIndex:provinceIndex];
    NSString *selected = [province objectAtIndex:provinceIndex];
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
    long cityIndex = [addressPicker selectedRowInComponent:1];
    NSString *currentCity = [city objectAtIndex:cityIndex];
    
    index = [sortedArray objectAtIndex:cityIndex];
    selected = [city objectAtIndex: cityIndex];
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
    long districtIndex = [addressPicker selectedRowInComponent:2];
    NSString *currentDistrict = [district objectAtIndex:districtIndex];
    
    
    // 地址信息存储在dictionary中
    NSDictionary *addressDic = [NSDictionary dictionaryWithObjectsAndKeys:self.name.text, @"name",
                                                                          self.phone.text, @"phone",
                                                                          currentProvince, @"province",
                                                                          currentCity, @"city",
                                                                          currentDistrict, @"district",
                                                                          self.detail.text, @"detail",
                                                                          nil];
    // 将地址存储到服务器中
    [Utils SaveAddress:addressDic];
}

- (void) selectDoneAction {
    [self.address endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // 三列：省、市、区县
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // 每列数据个数
    if (component == 0) {
        // 第一列：省
        return [province count];
    } else if (component == 1) {
        // 第二列：市
        return [city count];
    } else {
        // 第三列：区县
        return [district count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // 返回列每行数据名
    if (component == 0) {
        return [province objectAtIndex:row];
    } else if (component == 1) {
        return [city objectAtIndex:row];
    } else {
        return [district objectAtIndex:row];
    }
    
}

// 选中某列中某行所做处理
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        // 选中第一列中row行，更新该省所包含的市、区县信息
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
        
        // 获取选中省内所有市名称
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        city = [[NSArray alloc] initWithArray: array];
        
        // 获取选中省内第一个市所含区县名称
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [city objectAtIndex: 0]]];
        
        // 设定pickerview第二列和第三列都选中第一行
        [addressPicker selectRow: 0 inComponent: 1 animated: YES];
        [addressPicker selectRow: 0 inComponent: 2 animated: YES];
        [addressPicker reloadComponent: 1];
        [addressPicker reloadComponent: 2];
    } else if (component == 1) {
        // 选中第二列中row行，更新该市所包含的区县信息
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

// textfield进入输入状态时所做处理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 在编辑地址进入此页面的情况下，textfield中已经存在地址信息，当点击地址输入框时，显示的pickerview应该根据当前地址信息自动滚动到相应条目
    if ([self.type isEqualToString:@"editAddress"]) {
        // 获取当前地址信息
        NSDictionary *addressDic = [Utils GetAddress:self.AddressIndex];
        NSString *currentProvince = [addressDic valueForKey:@"province"];
        NSString *currentCity = [addressDic valueForKey:@"city"];
        NSString *currentDistrict = [addressDic valueForKey:@"district"];
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
        areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        
        // 设定pickerview第一列：省
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
        int i = 0;
        for (i = 0; i < [province count]; i++) {
            if ([[province objectAtIndex:i] isEqualToString:currentProvince]) {
                [addressPicker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
        
        // 设定pickerview第二列：市
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
        
        // 设定pickerview第三列：区县
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
    // textfield退出编辑状态时，将选中的省市区县信息拼接起来显示在textfield中
    NSInteger provinceRow = [addressPicker selectedRowInComponent:0];
    NSInteger cityRow = [addressPicker selectedRowInComponent:1];
    NSInteger districtRow = [addressPicker selectedRowInComponent:2];
    textField.text = [[[province objectAtIndex:provinceRow] stringByAppendingString:[city objectAtIndex:cityRow]] stringByAppendingString:[district objectAtIndex:districtRow]];
}
@end
