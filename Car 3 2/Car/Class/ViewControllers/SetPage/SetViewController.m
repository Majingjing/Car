//
//  SetViewController.m
//  Car
//
//  Created by jiabin on 16/3/9.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "SetViewController.h"

#import <AVOSCloud/AVOSCloud.h>

@interface SetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray *arr;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatTable];
    
    self.title = @"用户";
    
    self.arr = @[@"更改密码",@"清除缓存",@"注销登录"];
    
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"jiabin_cell"];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    // Do any additional setup after loading the view.
}

-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)creatTable{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height) style:UITableViewStylePlain];
    self.table.bounces = NO;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"jiabin_cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    return cell;
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更改密码" message:@"请输入注册时候的邮箱" preferredStyle:UIAlertControllerStyleAlert];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [AVUser requestPasswordResetForEmailInBackground:[alert.textFields firstObject].text block:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"请查看邮箱");
                        [self promptAction];
                    } else {
                        [self elsePromptAction];
                    }
                }];
            }];
            [alert addAction:cancelAction];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            [self outAction];
            break;
        }
            
        default:
            break;
    }
}

-(void)promptAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请前往邮箱查看" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AVUser logOut];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)elsePromptAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"邮箱号不匹配" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)outAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定注销?" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AVUser logOut];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:sureAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
