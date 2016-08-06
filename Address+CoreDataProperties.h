//
//  Address+CoreDataProperties.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/16.
//  Copyright © 2016年 孔令文. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address.h"
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSString *district;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *province;
@property (nullable, nonatomic, retain) NSNumber *addressNo;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
