//
//  User+CoreDataProperties.h
//  浩文眼睛OC
//
//  Created by 孔令文 on 16/7/7.
//  Copyright © 2016年 孔令文. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"
#import "Address.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *nickname;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *userImage;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSSet<Address *> *addresses;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addAddressesObject:(Address *)value;
- (void)removeAddressesObject:(Address *)value;
- (void)addAddresses:(NSSet<Address *> *)values;
- (void)removeAddresses:(NSSet<Address *> *)values;

@end

NS_ASSUME_NONNULL_END
