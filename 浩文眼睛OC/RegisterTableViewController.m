//
//  RegisterTableViewController.m
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/9/3.
//  Copyright © 2016年 孔令文. All rights reserved.
//

#import "RegisterTableViewController.h"
#import "Utils.h"

@interface RegisterTableViewController ()

@end

#define SUCCESS 0
#define USERNAME_EXISTED -1
#define PHONE_EXISTED -2
#define EMAIL_EXISTED -3
#define DATABASE_ERROR -10

@implementation RegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)submit:(id)sender {
    
    NSDictionary *userDic = [NSDictionary dictionaryWithObjectsAndKeys:self.tfUsername.text, @"username",
                             self.tfPassword.text, @"password",
                             self.tfPhone.text, @"phone",
                             self.tfEmail.text, @"email",
                             self.tfNickname.text, @"nickname", nil];
    
    int result = [Utils Registe:userDic];
    
    if (result != SUCCESS) {
        [self showOkayCancelAlert:result];
    } else if (result == PHONE_EXISTED) {
        
    } else if (result == EMAIL_EXISTED) {
        
    } else if (result == DATABASE_ERROR) {
        
    }
}
- (IBAction)clear:(id)sender {
    self.tfUsername.text = @"";
    self.tfPassword.text = @"";
    self.tfPhone.text = @"";
    self.tfEmail.text = @"";
    self.tfNickname.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showOkayCancelAlert:(int) errorNo {
    
    NSString *title = NSLocalizedString(@"登录错误", nil);
    NSString *message = @"";
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"OK", nil);
    
    if (errorNo == USERNAME_EXISTED) {
        message = NSLocalizedString(@"用户名已存在", nil);
    } else if (errorNo == PHONE_EXISTED) {
        message = NSLocalizedString(@"电话已被使用", nil);
    } else if (errorNo == EMAIL_EXISTED) {
        message = NSLocalizedString(@"邮箱已被使用", nil);
    } else if (errorNo == DATABASE_ERROR) {
        message = NSLocalizedString(@"系统错误", nil);
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        self.tfUsername.text = @"";
//        self.tfPassword.text = @"";
//        self.tfNickname.text = @"";
//        self.tfEmail.text = @"";
//        self.tfPhone.text = @"";
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
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
