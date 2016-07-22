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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)openUrlPush:(id)sender {
    [[UIApplication sharedApplication] openURL:[ViewController urlWithPrefix:@"ckddtest://" params:[self loadInstructionWithName:@"setCustomPropertyAndPush"]]];
}

- (NSString *)loadInstructionWithName:(NSString*)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSString *dispatchString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return dispatchString;
}

#pragma mark- Util

+ (NSURL *)urlWithPrefix:(NSString *)prefix params:(NSString *)params{
    if (prefix && params) {
        NSString *host = [NSString stringWithFormat:@"%@",prefix];
        NSString *urlString = [NSString stringWithFormat:@"%@?params=%@",host,params];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        return [NSURL URLWithString:urlString];
    }
    return nil;
}

+ (NSDictionary *)parseUrl:(NSURL *)url{
    if (url) {
        NSString *urlString = [url.absoluteString stringByRemovingPercentEncoding];
        NSArray *urlArray = [urlString componentsSeparatedByString:@"="];
        if (urlArray.count > 1) {
            return [NSJSONSerialization JSONObjectWithData:[[urlArray lastObject] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        }
    }
    return nil;
}
@end
