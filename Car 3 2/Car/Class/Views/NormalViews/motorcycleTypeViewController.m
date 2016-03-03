//
//  motorcycleTypeViewController.m
//  Car
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "motorcycleTypeViewController.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "MJRootView.h"
#import "PictureViewController.h"
#import "MineViewController.h"
@interface motorcycleTypeViewController ()<jumpDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation motorcycleTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    
    // Do any additional setup after loading the view.
}

- (void)jumpAction:(NSInteger)tag {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    switch (tag) {
        case 100:
            [self presentViewController:[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:nil] animated:YES completion:nil];
            break;
        case 101:
            
            break;
        case 102:
            [self presentViewController:[[ChaiViewController alloc] init] animated:YES completion:nil];
            break;
        case 103:
            [self presentViewController:[[PictureViewController alloc] init] animated:YES completion:nil];
            break;
        case 104:
            [self presentViewController:[[MineViewController alloc] init] animated:YES completion:nil];
            break;

        default:
            break;
    }
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
