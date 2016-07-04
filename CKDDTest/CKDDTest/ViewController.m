//
//  ViewController.m
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/1.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "ViewController.h"
#import "CKDispatcherCenter.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  推出一个页面
 *
 *  @param sender
 */
- (IBAction)justPushAction:(id)sender {
    [CKDispatcherCenter pushWithParams:[self loadInstructionWithName:@"push"] withNavigationController:self.navigationController];
}

/**
 *  设置属性并推出页面
 *
 *  @param sender
 */
- (IBAction)setPropertAndPushAction:(id)sender {
    [CKDispatcherCenter pushWithParams:[self loadInstructionWithName:@"setPropertyAndPush"] withNavigationController:self.navigationController];
}

/**
 *  设置自定义属性并推出页面
 *
 *  @param sender
 */
- (IBAction)setCustomPropertyAndPush:(id)sender {
    [CKDispatcherCenter pushWithParams:[self loadInstructionWithName:@"setCustomPropertyAndPush"] withNavigationController:self.navigationController];
}

/**
 *  调用实例方法并推出页面
 *
 *  @param sender
 */
- (IBAction)executeInstanceMethod:(id)sender {
    [CKDispatcherCenter pushWithParams:[self loadInstructionWithName:@"executeInstanceMethodAndPush"] withNavigationController:self.navigationController];
}

/**
 *  调用类方法并推出
 *
 *  @param sender 
 */
- (IBAction)executeClassMethod:(id)sender {
    [CKDispatcherCenter pushWithParams:[self loadInstructionWithName:@"executeClassMethod"] withNavigationController:self.navigationController];
}

- (IBAction)setPropertyAndPresent:(id)sender {
    UIViewController *viewController = [CKDispatcherCenter viewControllerWithParams:[self loadInstructionWithName:@"executeClassMethod"]];
    if (viewController && [viewController isKindOfClass:UIViewController.class]) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self.navigationController presentViewController:navi animated:YES completion:nil];
    }
}


- (NSString *)loadInstructionWithName:(NSString*)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSString *dispatchString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return dispatchString;
}
@end
