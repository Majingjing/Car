//
//  RootViewController.m
//  Car
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "RootViewController.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "MJRootView.h"

@interface RootViewController ()<jumpDelegate>

@end

@implementation RootViewController

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

            [self presentViewController:[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:[NSBundle mainBundle]] animated:YES completion:nil];
            break;
        case 101:
            [self presentViewController:[[motorcycleTypeViewController alloc] initWithNibName:@"motorcycleTypeViewController" bundle:nil] animated:YES completion:nil];
            break;
        case 102:

            [self presentViewController:[[ChaiViewController alloc] init] animated:YES completion:nil];
            break;
        case 103:
            break;
        case 104:
            [self presentViewController:[[ChaiViewController alloc] init] animated:YES completion:nil];
            break;

        default:
            break;
    }
}

/*
- (IBAction)showButton:(UIButton *)sender {
    self.upView = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 300, Width, 300)];
    self.upView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.upView];
    for (int i = 0; i < 5; i++) {
        if (i == 0 || i == 4) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake(((Width - 60) / 5  + 10)* i + 10 , 120, (Width - 60) / 5, (Width - 60) / 5)];
            self.lable = [[UILabel alloc] initWithFrame:CGRectMake(((Width - 60) / 5  + 10)* i + 10 , (Width - 60) / 5 + 120, (Width - 60) / 5, 30)];
            
        }
        if (i == 1 || i == 3) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake(((Width - 60) / 5  + 10)* i + 10 , 60, (Width - 60) / 5, (Width - 60) / 5)];
            self.lable = [[UILabel alloc] initWithFrame:CGRectMake(((Width - 60) / 5  + 10)* i + 10 , (Width - 60) / 5 + 60, (Width - 60) / 5, 30)];
            

        }
        if (i == 2) {
            self.button = [[UIButton alloc] initWithFrame:CGRectMake(((Width - 60) / 5  + 10)* i + 10 , 10, (Width - 60) / 5, (Width - 60) / 5)];
             self.lable = [[UILabel alloc] initWithFrame:CGRectMake(((Width - 60) / 5  + 10)* i + 10 , (Width - 60) / 5 + 20, (Width - 60) / 5, 30)];
        }
        self.button.tag = 100+i;
        self.lable.text = self.arr[i];
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.button.layer.cornerRadius = (Width - 60) / 10;
        self.button.backgroundColor = [UIColor greenColor];
        [self.button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.upView addSubview:self.button];
        [self.upView addSubview:self.lable];
        
    }
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(Width / 2 - 20, 260, 40, 40)];
    [button setTitle:@"X" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(downAction) forControlEvents:UIControlEventTouchUpInside];
    [self.upView addSubview:button];

   
}

- (void)tapAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            [self presentViewController:[[informationViewController alloc] init] animated:YES completion:nil];
            break;
        case 101:
            [self presentViewController:[[motorcycleTypeViewController alloc] init] animated:YES completion:nil];
        case 102:
            [self presentViewController:[[videoViewController alloc] init] animated:YES completion:nil];
        default:
            break;
    }
}


- (void)downAction {
    self.upView.frame = CGRectMake(0, Height, 0, 0);
}
 */
 
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
