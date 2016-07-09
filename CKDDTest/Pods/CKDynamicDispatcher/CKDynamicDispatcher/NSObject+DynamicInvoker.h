//
//  NSObject+DynamicInvoker.h
//  CKDDTest
//
//  Created by 陈凯 on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSObject (DynamicInvoker)

- (id)ck_invoke:(NSString *)selector argumentList:(NSArray * _Nullable)argumentList;

+ (id)ck_invoke:(NSString *)selector argumentList:(NSArray * _Nullable)argumentList;
@end
NS_ASSUME_NONNULL_END