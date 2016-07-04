//
//  SecondViewController.m
//  CKDDTest
//
//  Created by EasyBenefit on 16/7/4.
//  Copyright © 2016年 EasyBenefit. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property(nonatomic, strong)UILabel *statusLabel;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    if (self.navigationController.viewControllers.count==1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction:)];
    }
    
    if (_userId) {
        [self showStatus:[NSString stringWithFormat:@"userId = %@",_userId]];
    }
    
    if (_user) {
        [self showStatus:[NSString stringWithFormat:@"user.userName = %@",_user.userName]];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPropertyWithUserId:(NSString*)userId userName:(NSString*)userName{
    [self showStatus:[NSString stringWithFormat:@"setPropertyWithUserId:%@ userName:%@",userId, userName]];
}

+ (SecondViewController *)viewControllerUserId:(NSString*)userId userName:(NSString*)userName{
    
    SecondViewController *second = [[SecondViewController alloc] init];
    second.userId = userId;
    second.userName = userName;
    [second showStatus:[NSString stringWithFormat:@"viewControllerUserId:%@ userName:%@",userId,userName]];
    return second;
}

- (void)showStatus:(NSString*)status{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:17];
        _statusLabel.numberOfLines = 0;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_statusLabel];
        _statusLabel.frame = CGRectMake(20, 100, self.view.bounds.size.width-40, 200);
    }
    _statusLabel.text = status;
}

- (void)closeAction:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation UserModel

@end