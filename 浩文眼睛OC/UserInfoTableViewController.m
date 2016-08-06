//
//  UserInfoTableViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/24.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserDetailTableViewController.h"
#import "Utils.h"
#import "User.h"

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userNo = 0;
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    [ns addObserver:self selector:@selector(setData:) name:@"do" object:nil];
    
}

-(void)setData:(NSNotification *)sender {
    //NSLog(@"%@", sender);
    self.userNo = [[sender.userInfo valueForKey:@"index"] intValue];
    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (self.userNo == -1) {
        [cell.username setHidden:YES];
        [cell.btnLogin setHidden:NO];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
    } else {
        [cell.username setHidden:NO];
        [cell.btnLogin setHidden:YES];
        
        NSMutableArray *dataArray = [Utils GetUserInfo];
        User *user = [dataArray objectAtIndex:self.userNo];
        cell.username.text = user.username;
        NSString *url = user.userImage;
        if (url == nil) {
            cell.userImage.image = nil;
        } else {
            cell.userImage.image = (UIImage *)[Utils GetPhotoWithURL:url];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
    }

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"editUserInfo"]) {
        if (self.userNo == -1) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserDetailTableViewController *userDetail = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"editUserInfo"]) {
        userDetail.userNo = self.userNo;
        
    }
    
}

@end
