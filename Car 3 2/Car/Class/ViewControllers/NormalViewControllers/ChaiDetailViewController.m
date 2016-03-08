//
//  ChaiDetailViewController.m
//  Car
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "ChaiDetailViewController.h"
#import "InformationManager.h"
#import "ChaiDetailModel.h"

@interface ChaiDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (nonatomic,strong) ChaiDetailModel *model;


@end

@implementation ChaiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.997 green:0.968 blue:0.957 alpha:1.000];
    self.title = @"拆车坊--视频";

    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.338 green:0.366 blue:1.000 alpha:1.000];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackAction)];
    self.navigationItem.leftBarButtonItem = left;

    // Do any additional setup after loading the view from its nib.
}

- (void)goBackAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
-(void)loadData{
    [[InformationManager shareInstance] chaiCheVideoDetailSolve:self.urlString finish:^(ChaiDetailModel *model) {
        self.model = model;
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        NSMutableString *title = self.model.title.mutableCopy;
        [title appendFormat:@"\n%@",self.model.time];
        self.titleLabel.text = title;
        self.textLabel.text = self.model.littitle;
        NSURL *url = [NSURL URLWithString:self.model.vurl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
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
