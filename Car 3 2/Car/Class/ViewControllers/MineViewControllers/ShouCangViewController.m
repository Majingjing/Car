//
//  ShouCangViewController.m
//  Car
//
//  Created by jiabin on 16/3/9.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "ShouCangViewController.h"
#import "PicCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import <AVOSCloud/AVOSCloud.h>


@interface ShouCangViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@end

@implementation ShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [NSMutableArray array];
    [self loadData];
    self.title = @"我的";
    self.view.backgroundColor =[UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
//    [self loadData];
    [self creatCollectionView];
    
    [self.collectionView registerClass:[PicCollectionViewCell class] forCellWithReuseIdentifier:@"jiabin_collectionCell"];
    // Do any additional setup after loading the view.
//    [self.collectionView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
}

-(void)loadData{
    [self.data removeAllObjects];
    self.data = [[AVUser currentUser]objectForKey:@"images"];
    NSLog(@"%@",self.data);
    [self.collectionView reloadData];
   
}



-(void)creatCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout = layout;
    self.layout.itemSize = CGSizeMake((Width - 20) / 2, (Width-10)/2);
    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Width, Height) collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return self.data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"jiabin_collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    NSURL *url = [NSURL URLWithString:self.data[indexPath.row]];
    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dd"]];
    return cell;
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PicCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGSize size = cell.imageView.image.size;
    NSLog(@"%f,%f",size.height,size.width);
}




-(void)leftAction{
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
