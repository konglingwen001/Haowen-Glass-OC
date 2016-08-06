//
//  UserDetailTableViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/6/12.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "UserDetailTableViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "Utils.h"

@interface UserDetailTableViewController ()


@end

@implementation UserDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {

    NSMutableArray *dataArray = [Utils GetUserInfo];
    User *user = [dataArray objectAtIndex:self.userNo];
    if (user.userImage == nil) {
        self.userImage.image = nil;
    } else {
        self.userImage.image = (UIImage *)[Utils GetPhotoWithURL:user.userImage];
    }
    
    self.lblNickName.text = user.nickname;
    self.lblEmail.text = user.email;
    self.lblPhoneNum.text = user.phone;
}
- (IBAction)logout:(id)sender {
    [self showOkayCancelAlert];
}

- (void)showOkayCancelAlert {
    NSString *title = NSLocalizedString(@"退出登录", nil);
    NSString *message = NSLocalizedString(@"是否退出登录？", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"否", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"是", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[NSNumber numberWithInteger:-1], @"index", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"do" object:self userInfo:dic];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //if ([segue.identifier isEqualToString:@"editUserImage"]) {
        [segue.destinationViewController setValue:[NSNumber numberWithInt:self.userNo] forKey:@"userNo"];
    //}
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
