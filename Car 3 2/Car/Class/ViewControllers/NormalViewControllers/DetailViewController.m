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
#import "InformationManager.h"
@interface DetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
     UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = left;
    
    
    self.title = @"图片";
    //下面的view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, Height - 50, Width, 50)];
    
    //上一个
    UIButton *lastButton = [UIButton buttonWithType:UIButtonTypeSystem];
    lastButton.frame = CGRectMake(50, 0, 50, 30);
    [lastButton addTarget:self action:@selector(lastAction) forControlEvents:UIControlEventTouchUpInside];
    [lastButton setBackgroundImage:[UIImage imageNamed:@"上一张"] forState:UIControlStateNormal];
    [view addSubview:lastButton];
    
    //下一个
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"下一张"] forState:UIControlStateNormal];
    nextButton.frame = CGRectMake(Width - 100, 0, 50, 30);
    [nextButton addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextButton];
    
    //下面的label
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.center = CGPointMake(Width / 2, 25);
    [view addSubview:self.label];
    [self.view addSubview:view];
    
    //添加轮播图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130, Width, Height - 300)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    [self loadData:[[InformationManager shareInstance] modelIDbyIndex:self.page]];
 }



- (void)loadData:(NSInteger)index {
    [[InformationManager shareInstance] detailSolve:[NSString stringWithFormat:detailUrl,index] finish:^(NSMutableArray *arr) {
        
        self.scrollView.contentSize = CGSizeMake(Width * (arr.count + 1), Height - 300);
        self.count = arr.count;
        self.label.text = [NSString stringWithFormat:@"1/%ld", self.count];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(Width * arr.count,  0, Width, Height - 300);
        [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"NEXT ONE" forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        
        for (int i = 0; i < arr.count ; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Width * i, 0, Width, Height - 300)];
            DetailModel *model = [InformationManager shareInstance].pictureArr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImagePath]];
            [self.scrollView addSubview:imageView];
        }
    }];

}
- (void)lastAction {
    if (self.scrollView.contentOffset.x >= Width) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x - Width, 0);
        self.label.text = [NSString stringWithFormat:@"%.f/%ld",self.scrollView.contentOffset.x / Width + 1, self.count];
    }
}


- (void)nextAction {
    if (self.scrollView.contentOffset.x / Width <= self.count - 1) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + Width, 0);
        if (self.scrollView.contentOffset.x / Width > self.count - 1) {
            return;
        }
         self.label.text = [NSString stringWithFormat:@"%.f/%ld",self.scrollView.contentOffset.x / Width + 1, self.count];
    }
}

- (void)action {
    self.page++;
    [self loadData:[[InformationManager shareInstance] modelIDbyIndex:self.page]];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.scrollView.contentOffset.x / Width > self.count - 1) {
        return;
    }

   self.label.text = [NSString stringWithFormat:@"%.f/%ld",self.scrollView.contentOffset.x / Width + 1, self.count];
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
