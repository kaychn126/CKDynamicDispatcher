//
//  CKDispatcherCenter.m
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "CKDispatcherCenter.h"
#import "NSObject+CKDispatcher.h"

@implementation CKDispatcherCenter
+ (id)performInstanceAction:( CKDispatcherMethod * _Nullable )action
                 withTarget:( NSString * )target
           withPropertyList:( NSArray <CKDispatcherProperty *>* _Nullable )propertyList
{
    Class targetClazz = NSClassFromString(target);
    
    if (targetClazz) {
        id targetInstance = [[targetClazz alloc] init];
        
        if ([targetInstance isKindOfClass:UIViewController.class]) {
            UIViewController *targetViewController = (UIViewController*)targetInstance;
            //set property
            if (propertyList.count > 0) {
                [propertyList enumerateObjectsUsingBlock:^(CKDispatcherProperty * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    targetViewController.ck_property = obj;
                }];
            }
            
            //invoke method
            
        }
    }
    return nil;
}
@end

@implementation CKDispatcherMethod

@end

@implementation CKDispatcherProperty

@end