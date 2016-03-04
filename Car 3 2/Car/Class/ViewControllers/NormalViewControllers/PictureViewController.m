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
@interface PictureViewController ()<jumpDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *modelCollection;
@property (nonatomic, strong)UICollectionView *carCollection;
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"美女车模", @"汽车图片"]];
    segment.frame = CGRectMake(0, 20, Width, 30);
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    
    segment.selectedSegmentIndex = 0;
    
    [self creatModelCollection];
  
    
    // Do any additional setup after loading the view.
}
- (void)segmentAction:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
        
            break;
         case 1:
            break;
        default:
            break;
    }
}

- (void)creatModelCollection {
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.layout.itemSize = CGSizeMake((Width - 20) / 2, (Width - 20) / 2);
    self.modelCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, Width, Height - 50) collectionViewLayout:self.layout];
    [self.modelCollection registerClass:[ModelCollectionViewCell class] forCellWithReuseIdentifier:@"model"];
    self.modelCollection.backgroundColor = [UIColor whiteColor];
    self.modelCollection.delegate = self;
    self.modelCollection.dataSource = self;
    [self.view addSubview:self.modelCollection];
    [self.view insertSubview:self.modelCollection belowSubview:[MJRootView shareInstance]];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ModelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"model" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor yellowColor];
    cell.lable.text = @"123";
    cell.imageView.image = [UIImage imageNamed:@"10.png"];
    return cell;
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
