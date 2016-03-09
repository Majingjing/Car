//
//  RegiserViewController.m
//  Car
//
//  Created by lanou3g on 16/3/9.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "RegiserViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface RegiserViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UITextField *emailAddress;


@end

@implementation RegiserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)registerAction:(UIButton *)sender {
    AVUser *user = [AVUser user];
    user.username = self.userName.text;// 设置用户名
    user.password =  self.passWord.text;// 设置密码
    user.email = self.emailAddress.text;// 设置邮箱
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"注册成功");
            if (_delegate && [_delegate respondsToSelector:@selector(sendValue:word:)]) {
                [_delegate sendValue:self.userName.text word:self.passWord.text];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"注册失败%@",error);
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 80)];
            label.font = [UIFont systemFontOfSize:20];
            label.center = CGPointMake(self.view.center.x, self.view.center.y+30);
            label.textAlignment = NSTextAlignmentCenter;
            label.numberOfLines = 0;
            label.textColor = [UIColor redColor];
            label.text = @"注册失败\n用户名或邮箱不可用";
            [self.view addSubview:label];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [label removeFromSuperview];
            });
            
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
