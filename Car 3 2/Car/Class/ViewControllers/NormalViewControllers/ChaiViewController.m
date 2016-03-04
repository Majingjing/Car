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

#import "ChaiCheTableViewCell.h"
#import "WebViewController.h"

@interface ChaiViewController ()<UICollectionViewDataSource, UIBarPositioningDelegate, UICollectionViewDelegateFlowLayout,jumpDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UICollectionView *collection;
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
// 文章model数组
@property (nonatomic ,strong) NSMutableArray *chaiTextModelArr;
@property (nonatomic,assign) int count;

@end

@implementation ChaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chaiTextModelArr = [NSMutableArray array];
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
    
    
    self.table.scrollEnabled = NO;
    // Do any additional setup after loading the view.
}

-(void)loadTableViewData{
    NSString *string = [NSString stringWithFormat:chaiDataUrl,self.count];
    
    [[InformationManager shareInstance]chaiCheSolve:string finish:^(NSMutableArray *arr) {
        [self.chaiTextModelArr addObjectsFromArray:arr];
    }];
    [self.table reloadData];
}

- (void)jumpAction:(NSInteger)tag {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    switch (tag) {
        case 100:
            [self presentViewController:[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:nil] animated:YES completion:nil];
            break;
        case 101:
            [self presentViewController:[[motorcycleTypeViewController alloc] initWithNibName:@"motorcycleTypeViewController" bundle:nil] animated:YES completion:nil];
            break;
        case 102:
            
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
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
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
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
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
