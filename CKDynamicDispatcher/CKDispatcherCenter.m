//
//  CKDispatcherCenter.m
//  CKDDTest
//
//  Created by 陈凯 on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "CKDispatcherCenter.h"
#import "NSObject+CKDispatcher.h"
#import "NSObject+DynamicInvoker.h"
#import "CKDispatcherModel.h"

@implementation CKDispatcherCenter
+ (void) pushWithParams:(id)params withNavigationController:(UINavigationController *)navigationController{
    if (params) {
        id controller = [CKDispatcherCenter viewControllerWithParams:params];
        if (controller && [controller isKindOfClass:UIViewController.class] && navigationController) {
            [navigationController pushViewController:controller animated:YES];
        }
    }
}


+ (void) presentWithParams:(id)params
      withViewController:(UIViewController *)viewController{
    if (params) {
        UIViewController *controller = [CKDispatcherCenter viewControllerWithParams:params];
        if (controller && [controller isKindOfClass:UIViewController.class] && viewController) {
            [viewController presentViewController:controller animated:YES completion:nil];
        }
    }
}

+ (id) viewControllerWithParams:(id)params{
    @try {
        if ([params isKindOfClass:NSDictionary.class]) {
            NSString *target = [params valueForKey:@"target"];
            CKDispatcherMethod *action;
            
            if (target) {
                //propertyList
                NSArray *propertyDicList = [params valueForKey:@"propertyList"];
                NSMutableArray *propertyModelList = [NSMutableArray arrayWithCapacity:propertyDicList.count];
                
                if (propertyDicList.count > 0) {
                    for (NSDictionary *dic in propertyDicList) {
                        CKDispatcherProperty *propertyModel = [[CKDispatcherProperty alloc] initWithParams:dic];
                        [propertyModelList addObject:propertyModel];
                    }
                }
                
                //method
                NSDictionary *methodDic = [params valueForKey:@"action"];
                if (methodDic) {
                    action = [[CKDispatcherMethod alloc] initWithParams:methodDic];
                }
                
                return [CKDispatcherCenter performAction:action withTarget:target withPropertyList:propertyModelList];
            }
        } else if ([params isKindOfClass:NSString.class]) {
            NSData *jsonData = [params dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
            if (dic) {
                return [CKDispatcherCenter viewControllerWithParams:dic];
            }
            
            if (error) {
                NSLog(@"CKDispatcherCenter# %s [%d行]:%@", __FUNCTION__, __LINE__,error);
            }
        }
        return nil;
    } @catch (NSException *exception) {
        NSLog(@"CKDispatcherCenter# catchException %s [%d行]:%@", __FUNCTION__, __LINE__,exception);
    } @finally {
    }
}

/**
 *  属性赋值，执行方法，并返回return值
 *
 *  @param action       需要执行的方法
 *  @param target       目标页面类名
 *  @param propertyList 属性列表
 *
 *  @return 返回值
 */
+ (id)performAction:( CKDispatcherMethod * _Nullable )action
         withTarget:( NSString * )target
   withPropertyList:( NSArray <CKDispatcherProperty *>* _Nullable )propertyList
{
    Class targetClazz = NSClassFromString(target);
    
    if (targetClazz) {
        
        if (action && action.methodType == CKMethodTypeClass) {
            return [targetClazz ck_invoke:action.methodName argumentList:action.argumentList];
        }
        
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
            if (action) {
                if (action.methodType == CKMethodTypeInstance) {
                    [targetViewController ck_invoke:action.methodName argumentList:action.argumentList];
                }
            }
            return targetViewController;
        }
    }
    return nil;
}
@end
