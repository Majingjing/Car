//
//  MineViewController.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "MineViewController.h"
#import "MJRootView.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "PictureViewController.h"


#import "MineView.h"

@interface MineViewController ()<jumpDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)MineView *rootView;


@end

@implementation MineViewController

-(void)loadView{
    
    self.rootView = [[MineView  alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rootView;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    
    self.rootView.mineTableView.dataSource = self;
    self.rootView.mineTableView.delegate = self;
    
#pragma mark -- 注册cell
    
    [self.rootView.mineTableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"m_cell"];
    
    
    

}

- (void)jumpAction:(NSInteger)tag {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    switch (tag) {
        case 100:
            [self presentViewController:[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:nil] animated:YES completion:nil];
            break;
        case 101:
            [self presentViewController:[[motorcycleTypeViewController alloc] init] animated:YES completion:nil];
            break;
        case 102:
            [self presentViewController:[[ChaiViewController alloc] init] animated:YES completion:nil];
            break;
        case 103:
            [self presentViewController:[[PictureViewController alloc] init] animated:YES completion:nil];
            break;
        case 104:
            
            break;
            
        default:
            break;
    }
}

#pragma mark -- tableView  必须实现的方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"m_cell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"我的收藏";
            cell.textLabel.font = [UIFont  systemFontOfSize:23 weight:1];
            break;
        case 1:
            cell.textLabel.text = @"欢迎分享";
            cell.textLabel.font = [UIFont systemFontOfSize:23 weight:1];
            break;
        case 2:
            cell.textLabel.text = @"团队简介";
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



@end
