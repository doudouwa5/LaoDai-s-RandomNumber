//
//  ViewController.m
//  RandomNum_Demo
//
//  Created by admin on 2016/11/1.
//  Copyright © 2016年 AlezJi. All rights reserved.
//http://www.jianshu.com/p/b49735dd907e
//随机数

//设备的屏宽
#define MB_DEVICE_WIDTH     [[UIScreen mainScreen] bounds].size.width
//设备自适应Frame
#define MB_DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define LEFT_SPACE 30
#define LEFT_WIDTH 120
#define LEFT_HEIGHT 40



#import "ViewController.h"
#import "RondomNumHelper.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UITextFieldDelegate>
{
    BOOL isShowing;
    UILabel *_myshouNumLaber;
    UISwitch *_mySvitych;
    UILabel *_myToastlaber;
    UILabel *_myshowlaber;
    
    RondomNumHelper *rondomNum;

    NSMutableArray *_arrMut;
    NSArray *_arr;
    NSString *_str;
    NSString *_strOrder;
    long sum;

}

@property(nonatomic,strong)  UILabel *myshowlaber;
@property(nonatomic,strong) UISwitch *mySvitychIsOrder;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"laodai1"];
    imageView.alpha = 0.5;
    [self.view insertSubview:imageView atIndex:0];
    
    NSArray *arr = @[@"起始数",@"终止数",@"产生个数",@"是否可重复",@"是否需要排序",@"合计结果"];
    for(int i = 0;i < arr.count;i++){
        UILabel * laber = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_SPACE, LEFT_HEIGHT*i +80, LEFT_WIDTH, LEFT_HEIGHT)];
        laber.text = arr[i];
        [laber setTextColor:[UIColor blackColor]];
        laber.alpha = 0.8;
        [self.view addSubview:laber];
   
        if(i != arr.count-2  && i != arr.count-3){
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(140, LEFT_HEIGHT*i +80+10, LEFT_WIDTH, LEFT_HEIGHT-20)];
            textField.keyboardType=UIKeyboardTypeNumberPad;
            textField.placeholder=@"请输入";
            textField.layer.cornerRadius = 5.0;
            textField.returnKeyType = UIReturnKeyDone;
            textField.delegate = self;
            [textField setTextColor:[UIColor blackColor]];
            textField.tag = 2000+i;
            textField.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);//设置边框颜色
            textField.layer.borderWidth = 5.0f;//设置边框颜
            [self.view addSubview:textField];
            
            if(i == 0){
                textField.text = @"1";
            }
            if(i == 2){
                textField.text = @"1";
            }
            if(i==arr.count-1){
                textField.userInteractionEnabled = NO;
                textField.placeholder=@"";
            }
        }
    
    }
    
    _mySvitych=[[UISwitch alloc]init];//苹果官方的控件的位置设置，位置X，Y的值可以改变，宽度和高度值无法改变
    _mySvitych.frame=CGRectMake(140,LEFT_HEIGHT*3+80+5,LEFT_WIDTH,LEFT_HEIGHT);
    [_mySvitych setOn:YES animated:YES];
    [self.view addSubview:_mySvitych];
    //    [_mySvitych setOnTintColor:[UIColor redColor]];//投置开头按钮颜色
    //    [_mySvitych setThumbTintColor:[UIColor greenColor]];//设置整个颜色风格
    //    [_mySvitych setTintColor:[UIColor purpleColor]];
    
    _mySvitychIsOrder=[[UISwitch alloc]init];//苹果官方的控件的位置设置，位置X，Y的值可以改变，宽度和高度值无法改变
    _mySvitychIsOrder.frame=CGRectMake(140,LEFT_HEIGHT*4+80+5,LEFT_WIDTH,LEFT_HEIGHT);
    [_mySvitychIsOrder setOn:NO animated:YES];
    [_mySvitychIsOrder addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_mySvitychIsOrder];
    
    
    _myToastlaber = [[UILabel alloc] initWithFrame:CGRectMake((MB_DEVICE_WIDTH-210)/2,MB_DEVICE_HEIGHT - 120,200,20)];
    _myToastlaber.textAlignment=NSTextAlignmentCenter;
    [_myToastlaber setTextColor:[UIColor redColor]];
    _myToastlaber.font=[UIFont systemFontOfSize:13];
    _myToastlaber.alpha = 0.9;
    [self.view addSubview:_myToastlaber];
    
    
    
    _myshowlaber = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_mySvitych.frame)+40, MB_DEVICE_WIDTH-40, MB_DEVICE_HEIGHT - (CGRectGetMaxY(_mySvitych.frame)+40)-100)];
//    self.myshowlaber = [[UILabel alloc] init];
    self.myshowlaber.textAlignment=NSTextAlignmentCenter;
    self.myshowlaber.alpha = 0.9;
    self.myshowlaber.numberOfLines=0;//根据最大行数需求来设置
    [self.view addSubview:self.myshowlaber];
//    [self.myshowlaber mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self);
//        make.left.mas_equalTo(self).offset(30);
//        make.top.mas_equalTo(_mySvitych).offset(30);
//    }];
   
    
    //创建按钮
    UIButton*orangeBtn = [[UIButton alloc]init];
    orangeBtn.frame=CGRectMake((MB_DEVICE_WIDTH-200)/2,MB_DEVICE_HEIGHT - 80,200,LEFT_HEIGHT);
    //关键语句
    orangeBtn.layer.cornerRadius = 10.0;
    orangeBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);//设置边框颜色
    orangeBtn.layer.borderWidth = 5.0f;//设置边框颜色
    //设置背景色
    orangeBtn.backgroundColor= [UIColor blueColor];
    orangeBtn.alpha = 0.5;
    //设置按钮文字
    [orangeBtn setTitle:@"给老戴生产随机数"forState:UIControlStateNormal];
    [orangeBtn setTitle:@"赶紧放手"forState:UIControlStateHighlighted];
    //设置按钮按下时文字颜色
    [orangeBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateHighlighted];
    [orangeBtn addTarget:self action:@selector(setNum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orangeBtn];
    
    orangeBtn 

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];//收起键盘
    return YES;
}

-(void)setNum{
    
    _myshowlaber.text = @"";
    
    UITextField *Field1 = [self.view viewWithTag:2000];
    UITextField *Field2 = [self.view viewWithTag:2001];
    UITextField *Field3 = [self.view viewWithTag:2002];
    if(!Field1.text.length){
        [self showToast:@"最小从几开始呀老戴！！"];
        return;
    }
    if(!Field2.text.length){
        [self showToast:@"最大到几呀老戴！！"];
        return;
    }
    if(!Field3.text.length){
        [self showToast:@"老戴你想选几个数呀！！"];
        return;
    }
    if([Field1.text integerValue] > [Field2.text integerValue]){
        [self showToast:@"大数太小啦！！"];
        return;
    }
    if([Field1.text integerValue] == [Field2.text integerValue]){
        [self showToast:@"老戴这还用随机吗！！"];
        return;
    }
    
    
    int int1 = [Field1.text intValue];
    int int2 = [Field2.text intValue];
    int int3 = [Field3.text intValue];
    
    if(int2-int1+1<int3 && _mySvitych.isOn == NO){
        [self showToast:@"这样会崩的老戴！！"];
        return;
    }

    if(!rondomNum){
        rondomNum  = [[RondomNumHelper alloc] init];
    }
    
    _str = @"";
    _strOrder = @"";
    if(int3 == 1){
        int num = [rondomNum randFrom:int1 to:int2];
        sum = num;
        _str =[NSString stringWithFormat:@"%d", num];
        _strOrder =_str;
    }else{
        sum = 0;
        _arr = [rondomNum getRandomArrayform:int1 To:int2 num:int3 isCover:_mySvitych.isOn];
        _arrMut = [NSMutableArray arrayWithArray:_arr];
        [_arrMut sortUsingSelector:@selector(compare:)];
        
        for (int i = 0; i < _arr.count; i++) {
            
            sum = sum + [_arr[i] intValue];
            _str = [_str stringByAppendingString:[NSString stringWithFormat:@"  %@",_arr[i]]];
            _strOrder = [_strOrder stringByAppendingString:[NSString stringWithFormat:@"  %@",_arrMut[i]]];
        }
        
       
    }
    if(_mySvitychIsOrder.isOn){
        _myshowlaber.text = _strOrder;
    }else{
        _myshowlaber.text = _str;
    }
    
    UITextField *Field5 = [self.view viewWithTag:2005];
    Field5.text = [NSString stringWithFormat:@"%ld",sum];

}

-(void) showToast:(NSString *) str{
    
    if(!isShowing){
        _myToastlaber.text = str;
        isShowing = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _myToastlaber.text = @"";
            isShowing = NO;
        });
    }
}

-(void) switchAction:(UISwitch *)mySvitychIsOrder{
    if(_mySvitychIsOrder.isOn){
        _myshowlaber.text = _strOrder;
    }else{
        _myshowlaber.text = _str;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITextField *Field1 = [self.view viewWithTag:2000];
    UITextField *Field2 = [self.view viewWithTag:2001];
    UITextField *Field3 = [self.view viewWithTag:2002];

    [Field1 resignFirstResponder];
    [Field2 resignFirstResponder];
    [Field3 resignFirstResponder];

}
@end
