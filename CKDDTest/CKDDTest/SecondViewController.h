//
//  SecondViewController.h
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/4.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface SecondViewController : UIViewController

@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, strong) UserModel *user;

- (void)setPropertyWithUserId:(NSString*)userId userName:(NSString*)userName;

+ (SecondViewController *)viewControllerUserId:(NSString*)userId userName:(NSString*)userName;
@end

@interface UserModel : NSObject
@property (nonatomic, copy) NSString *userName;
@end