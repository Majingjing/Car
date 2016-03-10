//
//  LoginViewController.m
//  Car
//
//  Created by lanou3g on 16/3/9.
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
    self.view.backgroundColor = [UIColor cyanColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // Do any additional setup after loading the view from its nib.
}

-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)forgerPassWordAction:(UIButton *)sender {
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
            NSLog(@"登录失败%@",error);
        }
    }];
}

-(void)sendValue:(NSString *)name word:(NSString *)word{
    self.userName.text = name;
    self.passWord.text = word;
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
