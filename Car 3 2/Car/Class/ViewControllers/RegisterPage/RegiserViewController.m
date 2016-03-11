//
//  RegiserViewController.m
//  Car
//
//  Created by jiabin on 16/3/9.
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
            [user setObject:[NSMutableArray array] forKey:@"images"];
            [user saveInBackground];
            [self successAction];
        }else{
            NSLog(@"注册失败%@",error);
            [self remindAction];
            
        }
    }];
}


-(void)remindAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"用户名或邮箱不可用" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)successAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜你" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (_delegate && [_delegate respondsToSelector:@selector(sendValue:word:)]) {
            [_delegate sendValue:self.userName.text word:self.passWord.text];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
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
