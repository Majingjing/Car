//
//  LoginViewController.m
//  Car
//
//  Created by jiabin on 16/3/9.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "LoginViewController.h"
#import "RegiserViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface LoginViewController ()<sendMessageDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *passWord;




@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    imgView.image = [UIImage imageNamed:@"login"];
    [self.view insertSubview:imgView atIndex:0];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithRed:0.930 green:0.935 blue:0.979 alpha:0.5];
    [self.view insertSubview:view atIndex:1];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // Do any additional setup after loading the view from its nib.
}

-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)forgerPassWordAction:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置密码" message:@"请输入注册时邮箱" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AVUser requestPasswordResetForEmailInBackground:[alert.textFields firstObject].text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"请查看邮箱");
                [self promptAction];
            } else {
                [self elsePromptAction];
            }
        }];
    }];
    [alert addAction:cancelAction];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)promptAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请前往邮箱查看" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)elsePromptAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"邮箱号不正确" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}




- (IBAction)registerAction:(UIButton *)sender {
    
    RegiserViewController *rvc = [[RegiserViewController alloc] initWithNibName:@"RegiserViewController" bundle:nil];
    rvc.delegate = self;
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)loginAction:(UIButton *)sender {
    [AVUser logInWithUsernameInBackground:self.userName.text password:self.passWord.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登录成功");
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self failAction];
            NSLog(@"登录失败%@",error);
        }
    }];
}

-(void)sendValue:(NSString *)name word:(NSString *)word{
    self.userName.text = name;
    self.passWord.text = word;
}


-(void)failAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"用户名或密码不正确" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
