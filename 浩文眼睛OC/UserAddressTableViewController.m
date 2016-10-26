//
//  UserAddressTableViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/3.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserAddressTableViewController.h"
#import "UserAddressTableViewCell.h"
#import "Utils.h"
#import "User.h"
#import "Address.h"

@implementation UserAddressTableViewController

int addressCount = 0;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddressCount:) name:@"AddressCount" object:nil];
}

-(void) getAddressCount:(NSNotification *)noti {
    NSString *count = noti.userInfo[@"addressCount"];
    addressCount = [count intValue];
    [self.tableView reloadData];
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated {
    [Utils GetAddressCount];
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 获取地址个数
    return addressCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    NSDictionary *addressDic = [Utils GetAddress:(short)indexPath.row];
    NSString *address = [[[addressDic valueForKey:@"province"] stringByAppendingString:[addressDic valueForKey:@"city"]] stringByAppendingString:[addressDic valueForKey:@"district"]];
    NSString *detail = [addressDic valueForKey:@"detail"];
    cell.address.text = [address stringByAppendingString:detail];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除选中地址
        [Utils DeleteAddress:(short)indexPath.row];
        [tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setValue:[NSNumber numberWithInteger:self.userNo] forKey:@"userNo"];
    if ([segue.identifier isEqualToString:@"editAddress"]) {
        
        [segue.destinationViewController setValue:@"editAddress" forKey:@"type"];
        
        [segue.destinationViewController setValue:[NSNumber numberWithInteger:self.tableView.indexPathForSelectedRow.row] forKey:@"AddressIndex"];
    } else {
        [segue.destinationViewController setValue:@"addAddress" forKey:@"type"];
    }
    
}
@end
