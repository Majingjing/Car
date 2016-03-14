//
//  MineViewController.m
//  Car
//
//  Created by jiabin on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "MineViewController.h"
#import "MJRootView.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "PictureViewController.h"



#import "ShouCangViewController.h"
#import "IntroductionViewController.h"
#import "PositionViewController.h"
#import "LoginViewController.h"
#import "SetViewController.h"

#import "MineView.h"

#import <AVOSCloud/AVOSCloud.h>

@interface MineViewController ()<jumpDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)MineView *rootView;


@end

@implementation MineViewController

-(void)loadView{
    
    self.rootView = [[MineView  alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        self.rootView.stateLabel.text = currentUser.username;
    }else {
        //缓存用户对象为空时，可打开用户注册界面…
        self.rootView.stateLabel.text = @"点击登录";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.rootView addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    [self.rootView bringSubviewToFront:self.rootView.loginBtn];
    
    self.rootView.mineTableView.dataSource = self;
    self.rootView.mineTableView.delegate = self;
    
    [self.rootView.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark -- 注册cell
    
    [self.rootView.mineTableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"m_cell"];
    
}

-(void)loginAction{
    AVUser *currentUser = [AVUser currentUser];
    if (currentUser != nil) {
        NSLog(@"已经登录");
        SetViewController *svc = [[SetViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:svc];
        [self presentViewController:nvc animated:YES completion:nil];
    }else {
        LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
}

- (void)jumpAction:(NSInteger)tag {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    
    if (tag == 104) {
        return;
    }

    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil userInfo:@{@"tag":[NSNumber numberWithInteger:tag]}];
    }];

}

#pragma mark -- tableView  必须实现的方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"m_cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"炫车景点";
            cell.imageView.image = [UIImage imageNamed:@"地图"];
            cell.textLabel.font = [UIFont  systemFontOfSize:23 weight:1];
            break;
        case 1:
            cell.textLabel.text = @"我的收藏";
            cell.imageView.image = [UIImage imageNamed:@"收藏"];
            cell.textLabel.font = [UIFont systemFontOfSize:23 weight:1];
            break;
        case 2:
            cell.textLabel.text = @"团队简介";
            cell.imageView.image = [UIImage imageNamed:@"介绍"];
            cell.textLabel.font = [UIFont  systemFontOfSize:23 weight:1];
            break;
        default:
            break;
    }
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            PositionViewController *pvc = [[PositionViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:pvc];
            [self presentViewController:nvc animated:YES completion:nil];
            break;
        }
        case 1:{
            AVUser *currentUser = [AVUser currentUser];
            if (currentUser !=nil) {
                ShouCangViewController *lvc = [[ShouCangViewController alloc] init];
                UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
                [self presentViewController:nvc animated:YES completion:nil];
            }else{
                [self remindAction];
            }
            break;
        }
        case 2:{
            IntroductionViewController *ivc = [[IntroductionViewController alloc] init];
            UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:ivc];
            [self presentViewController:nvc animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

-(void)remindAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"没有登录" message:@"现在就去登录?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LoginViewController *lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:lvc];
        [self presentViewController:nvc animated:YES completion:nil];
    }];
    [alert addAction:cancelAction];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
