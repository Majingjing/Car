//
//  informationViewController.m
//  Car
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "informationViewController.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "MJRootView.h"
#import "PictureViewController.h"
#import "MineViewController.h"
#import "InformationModel.h"
#import "InformationManager.h"
#import "InformationTableViewCell.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"

@interface informationViewController ()<jumpDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)MJRootView *mjv;
@property (nonatomic, strong)UIScrollView *scrollView;
//存储解析出来的数据
@property (nonatomic, strong)NSMutableArray *arr;
//记录当前segment的index
@property (nonatomic, assign)NSInteger index;
//记录当前刷新的次数
@property (nonatomic, assign)int count;


// 轮播图地址数组
@property (nonatomic, strong) NSMutableArray *loopPicUrlArr;
// 图片新闻地址
@property (nonatomic, strong) NSMutableArray *loopPicNewsArr;
@property (nonatomic, strong)UIView *whiteView;
@property (nonatomic, strong)UIScrollView *loopPicView;
@end

@implementation informationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.arr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"InformationTableViewCell" bundle:nil] forCellReuseIdentifier:@"information"];
    [self update:1];
    
    
    self.count = 2;
    
    self.index = 1;
    
    [self loadLoopPicData];
    
    self.whiteView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView.hidden = YES;
    [self.view addSubview:self.whiteView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissAction:) name:@"dismiss" object:nil];
        // Do any additional setup after loading the view.
}

- (void)dismissAction:(NSNotification *)sender {
    [self jumpAction:[sender.userInfo[@"tag"] integerValue]];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
 
}


// 解析轮播图地址
-(void)loadLoopPicData{
    NSURL *url = [NSURL URLWithString:picUrlString];
    NSString *string = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray *arr = [string componentsSeparatedByString:@"\n"];
    self.loopPicUrlArr = [NSMutableArray array];
    self.loopPicNewsArr = [NSMutableArray array];
    for (NSString *str in arr) {
        if ([str containsString:@".jpg"]) {
            [self.loopPicUrlArr addObject:str];
        }else{
            [self.loopPicNewsArr addObject:str];
        }
    }
    
        self.loopPicView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, 200)];
        self.loopPicView.contentSize = CGSizeMake(Width*3, 200);
        self.loopPicView.pagingEnabled = YES;
        self.loopPicView.bounces = NO;
        for (int i = 0; i <3; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(Width*i, 0, Width, 200)];
            [imgView sd_setImageWithURL:[NSURL URLWithString:self.loopPicUrlArr[i]]];
            [self.loopPicView addSubview:imgView];
        }
        self.tableView.tableHeaderView = self.loopPicView;
    
}




- (IBAction)segmentAction:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex != 0) {
        self.tableView.tableHeaderView = [[UIView alloc] init];
    } else {
        [self loadLoopPicData];
    }
    
       self.count = 2;
    self.index = sender.selectedSegmentIndex + 1;
    [self update:sender.selectedSegmentIndex + 1];
 }


- (void)update:(NSInteger)indesx {
        [[InformationManager shareInstance] solve:[NSString stringWithFormat:informationUrl, indesx, 1, 1] finish:^(NSMutableArray *arr) {
       
         [self.arr removeAllObjects];
         [self.arr addObjectsFromArray:arr];
         [self.arr removeObjectAtIndex:self.arr.count - 1];
         [self.tableView reloadData];
         [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];

    }];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == self.arr.count - 2) {
        [[InformationManager shareInstance] solve:[NSString stringWithFormat:informationUrl, self.index, self.count, self.count] finish:^(NSMutableArray *arr) {
            [self.arr addObjectsFromArray:arr];
            [self.arr removeObjectAtIndex:self.arr.count - 1];
            [self.tableView reloadData];
            self.count = self.count + 2;
        }];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arr.count - 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"information" forIndexPath:indexPath];
    InformationModel *model = self.arr[indexPath.row];
    cell.model = model;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InformationModel *model = self.arr[indexPath.row];
    WebViewController *webView = [[WebViewController alloc] init];
    webView.url = model.url;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:webView];
    [self presentViewController:nvc animated:YES completion:nil];
    
}



- (void)jumpAction:(NSInteger)tag {
     [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    if (tag != 100) {
        self.whiteView.hidden = NO;
    } else {
        self.whiteView.hidden = YES;
    }
    switch (tag) {
        case 100:
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
            [self presentViewController:[[MineViewController alloc] init] animated:YES completion:nil];
            break;
    
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
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
