//
//  ChaiViewController.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "ChaiViewController.h"
#import "MJRootView.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "PictureViewController.h"
#import "MineViewController.h"
#import "InformationManager.h"
#import "UIImageView+WebCache.h"
#import "ChaiCheModel.h"
#import "ChaiCheVideoModel.h"

#import "ChaiCheTableViewCell.h"
#import "WebViewController.h"
#import "ChaiVideoCollectionViewCell.h"
#import "ChaiDetailViewController.h"


@interface ChaiViewController ()<UICollectionViewDataSource, UIBarPositioningDelegate, UICollectionViewDelegateFlowLayout,jumpDelegate, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate>
@property (nonatomic, strong)UICollectionView *collection;
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
// 文章model数组
@property (nonatomic ,strong) NSMutableArray *chaiTextModelArr;
@property (nonatomic,strong) NSMutableArray *chaiVideoModelArr;

@property (nonatomic,assign) int count;

@end

@implementation ChaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chaiTextModelArr = [NSMutableArray array];
    self.chaiVideoModelArr = [NSMutableArray array];
    self.count = 1;
    
    
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segment =  [[UISegmentedControl alloc] initWithItems:@[@"视频", @"文章"]];
    segment.frame = CGRectMake(0, 20, Width, 30);
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    
    [self creatTableView];

    [self creatCollection];
    segment.selectedSegmentIndex = 0;
    
    
    [self loadTableViewData];
    [self loadCollectionData];
    
    self.table.scrollEnabled = NO;

}

-(void)loadTableViewData{
    
    NSString *string = [NSString stringWithFormat:chaiDataUrl,self.count];
    
    [[InformationManager shareInstance]chaiCheSolve:string finish:^(NSMutableArray *arr) {
        [self.chaiTextModelArr addObjectsFromArray:arr];
    }];
    [self.table reloadData];
}

-(void)loadCollectionData{
    
    NSString *string = [NSString stringWithFormat:chaiVideoDataUrl,self.count];
    [[InformationManager shareInstance]chaiCheVideoSolve:string finish:^(NSMutableArray *arr) {
        [self.chaiVideoModelArr addObjectsFromArray:arr];
        [self.collection reloadData];
    }];
    
}

- (void)jumpAction:(NSInteger)tag {
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil userInfo:@{@"tag":[NSNumber numberWithInteger:tag]}];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    }];

}

- (void)segmentAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.collection.hidden = NO;
            self.table.hidden = YES;
            break;
         case 1:
            [self creatTableView];
            self.collection.hidden = YES;
            self.table.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)creatCollection {
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.layout.itemSize = CGSizeMake((Width - 20) / 2, (Width - 20) / 2);
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, Width, Height - 50) collectionViewLayout:self.layout];
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.collection registerNib:[UINib nibWithNibName:@"ChaiVideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"VideoCell"];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.view addSubview:self.collection];
    [self.view insertSubview:self.collection belowSubview:[MJRootView shareInstance]];

}

- (void)creatTableView {
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, Width, Height - 50) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerNib:[UINib nibWithNibName:@"ChaiCheTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    [self.view addSubview:self.table];
    [self.view insertSubview:self.table belowSubview:[MJRootView shareInstance]];
    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chaiVideoModelArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChaiVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoCell" forIndexPath:indexPath];
    ChaiCheVideoModel *model = self.chaiVideoModelArr[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.covimg] placeholderImage:[UIImage imageNamed:@"chachewenzhang"]];
    cell.titleLabel.text = model.title;
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ChaiDetailViewController *dbc = [[ChaiDetailViewController alloc] init];
    ChaiCheVideoModel *model = self.chaiVideoModelArr[indexPath.row];
    NSString *string = [NSString stringWithFormat:chaiVideoUrl,model.Nid];
    dbc.urlString = string;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:dbc];
    [self presentViewController:nvc animated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chaiTextModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChaiCheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    ChaiCheModel *model = self.chaiTextModelArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *wbc = [[WebViewController alloc] init];
    ChaiCheModel *model = self.chaiTextModelArr[indexPath.row];
    wbc.url = model.url;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:wbc];
    [self presentViewController:nvc animated:YES completion:nil];
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
