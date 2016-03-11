//
//  PositionViewController.m
//  Car
//
//  Created by jiabin on 16/3/8.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "PositionViewController.h"

@interface PositionViewController ()

@end

@implementation PositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定位";
    self.view.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // Do any additional setup after loading the view.
}


-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
