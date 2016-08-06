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

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    NSMutableSet *addresses = [user.addresses mutableCopy];
    return [addresses count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    NSMutableSet *addresses = [user.addresses mutableCopy];
    NSArray *components = [addresses allObjects];
    NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 addressNo] < [obj2 addressNo]) {
            return (NSComparisonResult)NSOrderedAscending;
        } else if([obj1 addressNo] > [obj2 addressNo]) {
            return (NSComparisonResult)NSOrderedDescending;
        } else {
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    Address *address = [sortedArray objectAtIndex:indexPath.row];
    cell.address.text = [[[address.province stringByAppendingString:address.city] stringByAppendingString:address.district] stringByAppendingString:address.detail];
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *dataArray = [Utils GetUserInfo];
        User *user = [dataArray objectAtIndex:self.userNo];
        NSMutableSet *addresses = [user.addresses mutableCopy];
        
        NSArray *components = [addresses allObjects];
        
        NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 addressNo] < [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if([obj1 addressNo] > [obj2 addressNo]) {
                return (NSComparisonResult)NSOrderedDescending;
            } else {
                return (NSComparisonResult)NSOrderedSame;
            }
        }];
        for (int i = 0; i < [sortedArray count]; i++) {
            if (i  == indexPath.row) {
                [user removeAddressesObject:[sortedArray objectAtIndex:i]];
                break;
            }
        }
        [Utils SaveUserInfo:user AtIndex:self.userNo];
        [tableView reloadData];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [segue.destinationViewController setValue:[NSNumber numberWithInteger:self.userNo] forKey:@"userNo"];
    if ([segue.identifier isEqualToString:@"editAddress"]) {
        
        [segue.destinationViewController setValue:@"editAddress" forKey:@"type"];
        
        [segue.destinationViewController setValue:[NSNumber numberWithInteger:self.tableView.indexPathForSelectedRow.row] forKey:@"tmpAddressNo"];
    } else {
        [segue.destinationViewController setValue:@"addAddress" forKey:@"type"];
    }
    
}
@end
