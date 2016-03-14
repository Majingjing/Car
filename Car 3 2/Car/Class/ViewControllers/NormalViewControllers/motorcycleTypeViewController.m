//
//  motorcycleTypeViewController.m
//  Car
//
//  Created by mj on 16/3/1.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "motorcycleTypeViewController.h"
#import "informationViewController.h"
#import "motorcycleTypeViewController.h"
#import "ChaiViewController.h"
#import "MJRootView.h"
#import "PictureViewController.h"
#import "MineViewController.h"




#pragma mark --- SYH 

#import "mThirdViewController.h"

#import "moroCycleTableViewCell.h"

#import "mosCycleTableViewCell.h"

#import "SYHNetTools.h"

#import "moroManger.h"

#import "morosManger.h"

#import "moroModel.h"

#import "morosModel.h"

#import  "UIImageView+WebCache.h"

static NSString *Identifer = @"Mcell";

static NSString *msIdentifier = @"msCell";


@interface motorcycleTypeViewController ()<jumpDelegate,UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MTableLeading;
#pragma mark -- SYH 车型页面的 tableview

@property (weak, nonatomic) IBOutlet UITableView *motorccleTable;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;


#pragma mark 新添加的属性
@property (nonatomic, assign)NSInteger brandId;

@property (nonatomic, strong)NSMutableArray *brandIdArray;

@property (nonatomic, strong)NSMutableArray *data;

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic,assign) BOOL isOpening;

@end

@implementation motorcycleTypeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:[MJRootView shareInstance]];
    [MJRootView shareInstance].delegate = self;
    
    self.isOpening = NO;
#pragma mark -- 获取 Xib 中的tableView
    
    [self.motorccleTable registerNib:[UINib nibWithNibName:@"moroCycleTableViewCell" bundle:nil] forCellReuseIdentifier:Identifer];
    
    [self.mTableView registerNib:[UINib  nibWithNibName:@"mosCycleTableViewCell" bundle:nil] forCellReuseIdentifier:msIdentifier];
    
#pragma mark -- 调用解析方法
    [[moroManger  shareInstanceMotorcycle] requestMotocleWithUrl:MorocleUrl didFinsn:^{
        
        [self.motorccleTable reloadData];
        
    }];
    
#pragma mark  数组初始化
    self.brandIdArray = [NSMutableArray array];
    self.data = [NSMutableArray array];
    
}

- (void)swipAction
{
    /*
     [UIView animateWithDuration:0.7 animations:^{
     self.mTableView.frame = CGRectMake(self.view.frame.size.width - self.mTableView.frame.size.width, 0, self.mTableView.frame.size.width, self.view.frame.size.height);
     }];0
     */
    
    [[moroManger  shareInstanceMotorcycle] requestMotocleWithUrl:MorocleUrl didFinsn:^{
#pragma mark -- 值的传递与数据的解析
        
  self.brandIdArray = [moroManger
                             shareInstanceMotorcycle].morocleArr;
        moroModel *model = self.brandIdArray[self.indexPath.row];

        self.brandId = model.brandId;
        
      
        NSString *url = [NSString stringWithFormat:MscleUrl,self.brandId];
        [[morosManger  shareInstanceMsclecy] requestMscycleWithUrl:url didFinsn:^{
//            self.data = [morosManger shareInstanceMsclecy].msArr;
            [UIView animateWithDuration:0.7 animations:^{
                CGRect rect = self.mTableView.frame;
                rect.origin.x -= 240;
                self.mTableView.frame = rect;
                self.isOpening = YES;
            }];
            [self.mTableView reloadData];
        }];
    }];
    
    
    UIButton *tapBtn = [UIButton  buttonWithType:UIButtonTypeSystem];
                        
    tapBtn.frame = CGRectMake(0, 0, Width, Height);
    
    
    [self.view  insertSubview:tapBtn atIndex:2];
    [tapBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapAction:(UIButton *)sender {
    if (self.isOpening) {
        [sender removeFromSuperview];
        [UIView animateWithDuration:0.7 animations:^{
            CGRect rect = self.mTableView.frame;
            rect.origin.x += 240;
            self.mTableView.frame = rect;
            self.isOpening = NO;
        }];
    }
}

#pragma mark -- tableView 必须实现的方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.motorccleTable) {
        
        return [[moroManger  shareInstanceMotorcycle] countOfArray ];
    }
    else{
        
        return [[morosManger shareInstanceMsclecy] countMsOfArray ];
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //  if 判断当前选中的是那个tableview
    if(tableView == self.motorccleTable)
    {
        moroCycleTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:Identifer forIndexPath:indexPath];
        cell.modelMTtype = [[moroManger shareInstanceMotorcycle]modelWithIndex:indexPath.row ];
        
        [self.mTableView reloadData];
       
        return cell;
    }
    else
    {
        mosCycleTableViewCell *cell = [self.mTableView dequeueReusableCellWithIdentifier:msIdentifier forIndexPath:indexPath];
#pragma mark --  model  的获取
        morosModel *model = [morosManger shareInstanceMsclecy].msArr[indexPath.row];
        
        cell.morosNamelable.text = model.seriesName;
        
        
        cell.morosPriceLable.text = model.guidePrice;
        
        [cell.morosImageView sd_setImageWithURL:[NSURL URLWithString:model.imagePath ] placeholderImage:[UIImage  imageNamed:@"2.jpg"]];
    
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.motorccleTable)
    {
#pragma mark 下标的获取
        
        self.indexPath = indexPath;
        [self swipAction];
        
        //[self.mTableView reloadData];
    }
    else{
        
        mThirdViewController *mvc = [[mThirdViewController  alloc] init];
        
        // 通过下标获取模型
        morosModel *model = [morosManger shareInstanceMsclecy].msArr[indexPath.row];
        
        UINavigationController *mnvc = [[UINavigationController  alloc] initWithRootViewController:mvc];
        
        mvc.textMS = model.wapURL;
        [self presentViewController:mnvc animated:YES completion:nil];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
    
}
- (void)jumpAction:(NSInteger)tag {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"downAction" object:nil];

    if (tag == 101) {
        return;
    }
    [self dismissViewControllerAnimated:NO completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil userInfo:@{@"tag":[NSNumber numberWithInteger:tag]}];
    }];
    
    
}






@end
