//
//  PictureViewController.m
//  Car
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "PictureViewController.h"
#import "MJRootView.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "ModelCollectionViewCell.h"
#import "MineViewController.h"
#import "InformationManager.h"
#import "PictureModel.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "DetailViewController.h"
@interface PictureViewController ()<jumpDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *modelCollection;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,strong)NSArray *arr;
@property (nonatomic, strong)NSMutableArray *Picturearr;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Picturearr = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"美女车模", @"汽车图片"]];
    segment.frame = CGRectMake(0, 20, Width, 30);
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    
    segment.selectedSegmentIndex = 0;
    
    
    self.arr = @[girlPictureUrl, carPictureUrl];
    
    [self solve:self.arr[0]];
    // Do any additional setup after loading the view.
}

- (void)segmentAction:(UISegmentedControl *)sender {
    NSLog(@"123");
    [self.Picturearr removeAllObjects];
    [self solve:self.arr[sender.selectedSegmentIndex]];
    
}

- (void)solve: (NSString *)url {
    NSLog(@"aaaaa = %@", url);
    [[InformationManager shareInstance] pictureSolve:url finish:^(NSMutableArray *arr) {
        [self creatModelCollection];
        [self.Picturearr addObjectsFromArray:arr];
        
        [self.modelCollection reloadData];
    }];

}

- (void)creatModelCollection {
    NSLog(@"456");
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.layout.itemSize = CGSizeMake((Width - 20) / 2, (Width - 20) / 2);
    self.modelCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, Width, Height - 50) collectionViewLayout:self.layout];
    self.modelCollection.backgroundColor = [UIColor redColor];
 
    [self.modelCollection registerClass:[ModelCollectionViewCell class] forCellWithReuseIdentifier:@"model"];
    self.modelCollection.backgroundColor = [UIColor whiteColor];
    self.modelCollection.delegate = self;
    self.modelCollection.dataSource = self;
    [self.view addSubview:self.modelCollection];
    [self.view insertSubview:self.modelCollection belowSubview:[MJRootView shareInstance]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.Picturearr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"model" forIndexPath:indexPath];
    PictureModel *model = self.Picturearr[indexPath.row];
    cell.lable.text = [NSString stringWithFormat:@"%@共%ld张图片",model.albumName,model.picNumber];
    NSLog(@"%ld", model.picNumber);
    NSLog(@"%@", model.albumName);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imagePath]];
    NSLog(@"%@", model.imagePath);
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    DetailViewController *dvc = [[DetailViewController alloc] init];
    PictureModel *model = self.Picturearr[indexPath.row];
    dvc.page = model.albumId;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:dvc];
    [self presentViewController:nvc animated:YES completion:nil];
    
}



- (void)jumpAction:(NSInteger)tag {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];
    switch (tag) {
        case 100:
            [self presentViewController:[[informationViewController alloc] initWithNibName:@"informationViewController" bundle:nil] animated:YES completion:nil];
            break;
        case 101:
            [self presentViewController:[[motorcycleTypeViewController alloc] init] animated:YES completion:nil];
            break;
        case 102:
            [self presentViewController:[[ChaiViewController alloc] init] animated:YES completion:nil];
            break;
        case 103:
            break;
        case 104:
            [self presentViewController:[[MineViewController alloc] init] animated:YES completion:nil];
            break;

        default:
            break;
    }
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
