//
//  NSObject+CKDispatcher.h
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CKDispatcherProperty;
@interface NSObject (CKDispatcher)
@property(nonatomic, strong) CKDispatcherProperty *ck_property;
@end
