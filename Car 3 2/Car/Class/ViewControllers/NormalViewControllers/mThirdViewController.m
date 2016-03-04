//
//  mThirdViewController.m
//  Car
//
//  Created by 史燕红 on 16/3/3.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "mThirdViewController.h"

@interface mThirdViewController ()

@end

@implementation mThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftBtn)];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL  URLWithString:self.textMS]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
   
}


-(void)leftBtn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
