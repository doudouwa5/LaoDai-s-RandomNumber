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

@interface HDDMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) HDDBannerView *bannerView;
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
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HDDMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HDDMineCell"];
    return cell;
}

-(HDDBannerView *) bannerView{
    if (!_bannerView) {
        _bannerView = [[[NSBundle mainBundle] loadNibNamed:@"HDDBannerView" owner:self options:nil] firstObject];
    }
    return _bannerView;
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
