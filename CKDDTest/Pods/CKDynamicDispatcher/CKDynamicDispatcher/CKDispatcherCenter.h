//
//  CKDispatcherCenter.h
//  CKDDTest
//
//  Created by 陈凯 on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKDispatcherCenter : NSObject

#pragma mark- Core
/**
 *  用push方式导航到目标页面
 *
 *  @param params               目标页面参数（NSDictionary或者json格式的字符串）
 *  @param navigationController navigationController
 *
 */
+ (void) pushWithParams:(id)params
    withNavigationController:(UINavigationController *)navigationController;

/**
 *  根据参数获取目标页面
 *
 *  @param params 目标页面参数（格式为NSDictionary或者json格式的字符串）
 *
 *  @return 当CKMethodType为CKMethodTypeInstance的时候返回目标页面实例，当CKMethodType为CKMethodTypeClass时返回nil
 */
+ (id) viewControllerWithParams:(id)params;

@end

NS_ASSUME_NONNULL_END