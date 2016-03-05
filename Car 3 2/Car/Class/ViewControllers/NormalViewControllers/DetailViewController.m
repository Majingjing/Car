//
//  DetailViewController.m
//  Car
//
//  Created by lanou3g on 16/3/4.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "DetailViewController.h"
#import "InformationManager.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
     UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, Width, 30)];
    label.text = @"图片";
    [self.view addSubview:label];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 50, Width, 50)];
    
    UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lastButton.frame = CGRectMake(50, 0, 50, 30);
    [lastButton setBackgroundImage:[UIImage imageNamed:@"上一张"] forState:UIControlStateNormal];
    [view addSubview:lastButton];
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"下一张"] forState:UIControlStateNormal];
    nextButton.frame = CGRectMake(Width - 100, 0, 50, 30);
    [view addSubview:nextButton];
    
    [self.view addSubview:view];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, Width, Height - 300)];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [[InformationManager shareInstance] detailSolve:[NSString stringWithFormat:detailUrl,self.page] finish:^(NSMutableArray *arr) {
     scrollView.contentSize = CGSizeMake(Width * arr.count, Height - 300);

        for (int i = 0; i < arr.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Width * i, 0, Width, Height - 300)];
            DetailModel *model = [InformationManager shareInstance].Modelarr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImagePath]];
            NSLog(@"aaaaaaaa = %@", [InformationManager shareInstance].Modelarr[i]);
            [scrollView addSubview:imageView];
        }
    }];
    
    [self.view addSubview:scrollView];

    // Do any additional setup after loading the view.
}
- (void)leftAction {
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
