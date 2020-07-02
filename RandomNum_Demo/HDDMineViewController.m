//
//  HDDMineViewController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDMineViewController.h"
#import "HDDBannerView.h"
#import "HDDMineCell.h"
#import "HDDMineCellModel.h"

@interface HDDMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) HDDBannerView *bannerView;
@property(nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation HDDMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    [self setSettingBtn];
    [self setMessageBtn];
    
    [self.view addSubview:self.bannerView];
    [self.tableView registerNib:[UINib nibWithNibName:@"HDDMineCell" bundle:nil] forCellReuseIdentifier:@"HDDMineCell"];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.frame.size.width/2);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bannerView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    self.tableView.tableFooterView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
}



#pragma  mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDDMineCellModel *model = self.dataArr[indexPath.row];
    HDDMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HDDMineCell"];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HDDMineCellModel *model = self.dataArr[indexPath.row];
    if(model.url){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url] options:@{} completionHandler:nil];
    }
}

-(HDDBannerView *) bannerView{
    if (!_bannerView) {
        _bannerView = [[[NSBundle mainBundle] loadNibNamed:@"HDDBannerView" owner:self options:nil] firstObject];
    }
    return _bannerView;
}


-(NSMutableArray *)dataArr{
    if(!_dataArr){
        _dataArr = [[NSMutableArray alloc] init];
        
        HDDMineCellModel *model1 = [HDDMineCellModel new];
        model1.imageName = @"banbenhao";
        model1.tittle = @"APP描述";
        model1.des = @"这是老戴减肥专用APP，仅供内部使用";
        model1.imageName = @"miaoshu";
        model1.hiddenRightImage = YES;
        [_dataArr addObject:model1];
        
//        HDDMineCellModel *model2 = [HDDMineCellModel new];
//        model2.imageName = @"banbenhao";
//        model2.tittle = @"tittle1";
//        model2.des = @"des1";
//        model2.hiddenRightImage = YES;
//        [_dataArr addObject:model2];
        
        HDDMineCellModel *model3 = [HDDMineCellModel new];
        model3.imageName = @"banbenhao";
        model3.tittle = [NSString stringWithFormat:@"当前版本号为: %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        model3.des = @"点击查看更新";
        model3.url = @"https://www.pgyer.com/Eqwm";
        model3.hiddenRightImage = NO;
        [_dataArr addObject:model3];

    }
    return _dataArr;
}

-(void) setMessageBtn{
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 0, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightButton addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem  = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void) setSettingBtn{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"Settingscontroloptions"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem  = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void) messageClick{
    
}

-(void) settingClick{
    
}

@end
