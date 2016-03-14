//
//  DetailViewController.m
//  Car
//
//  Created by mj on 16/3/4.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "DetailViewController.h"
#import "InformationManager.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "InformationManager.h"
#import <AVOSCloud/AVOSCloud.h>


@interface DetailViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
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
        button.frame = CGRectMake(Width * arr.count + Width / 2, Height / 2, 100, 100);
        [button addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"下一图集" forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        
        
        
        
        for (int i = 0; i < arr.count ; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Width * i, 0, Width, Height - 300)];
            
            DetailModel *model = [InformationManager shareInstance].pictureArr[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.bigImagePath]];
            imageView.userInteractionEnabled = YES;
            imageView.tag = 100+i;
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longAction:)];
            [imageView addGestureRecognizer:longPress];
            [self.scrollView addSubview:imageView];
        }
    }];

}





-(void)longAction:(UITapGestureRecognizer *)sender{
   
    if (sender.state == UIGestureRecognizerStateBegan) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更多" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *shouCangAction = [UIAlertAction actionWithTitle:@"收藏到云端" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([AVUser currentUser] == nil) {
                [self remindAction];
                return;
            }
            NSMutableArray *arr = [[AVUser currentUser]objectForKey:@"images"];
            DetailModel *model = [InformationManager shareInstance].pictureArr[sender.view.tag-100];
            [arr addObject:model.bigImagePath];
            NSLog(@"%@",arr);
            [[AVUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [[AVUser currentUser] setObject:arr forKey:@"images"];
                [[AVUser currentUser] saveInBackground];
            }];
            
        }];
        UIAlertAction *baocunAction = [UIAlertAction actionWithTitle:@"保存到本地" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageView *imgView = [self.view viewWithTag:sender.view.tag];;
            UIImageWriteToSavedPhotosAlbum(imgView.image, nil, nil,nil);
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:shouCangAction];
        [alert addAction:baocunAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)remindAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"先去登录吧" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:Action];
    [self presentViewController:alert animated:YES completion:nil];
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
         self.label.text = [NSString stringWithFormat:@"%.f/%ld",self.scrollView.contentOffset.x / Width + 1, self.count];

    }
    
}

- (void)action {
    self.page++;
    [self loadData:[[InformationManager shareInstance] modelIDbyIndex:self.page]];
    self.scrollView.contentOffset = CGPointMake(0, 0);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
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
