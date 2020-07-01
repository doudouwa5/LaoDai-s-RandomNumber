//
//  HDDHomeViewController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDHomeViewController.h"
#import "RondomNumHelper.h"

@interface HDDHomeViewController ()
{
    NSString *_str;
    NSString *_strOrder;
    NSString *_strRecord;
    int sum;
    NSArray *_arr;
    NSMutableArray *_arrMut;
}
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *startNum;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *endNum;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *num;
@property (weak, nonatomic) IBOutlet UILabel *resultLab;
@property (weak, nonatomic) IBOutlet UISwitch *isRepetitionSW;
@property (weak, nonatomic) IBOutlet UISwitch *isOrderSW;
@property (weak, nonatomic) IBOutlet UISwitch *isSaveSW;
@property (weak, nonatomic) IBOutlet UILabel *recordLab;
@property (strong, nonatomic) RondomNumHelper *rondomNum;
@property (weak, nonatomic) IBOutlet NMEButton *clearBtn;

@end

@implementation HDDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"老戴的随机数";
    [self setView];
}

-(void) setView{
    
    self.resultLab.text = @"";
    self.recordLab.text = @"";

    _strRecord = @"";
    [self.isOrderSW setOn:NO];
    self.clearBtn.hidden = YES;
    
    WeakSelf(self)
    weakself.startNum.placeholder = @"请输入起始数字";
    weakself.startNum.text = @"1";
    weakself.startNum.inputType = NMEFloatFieldInputTypeNum;
    weakself.startNum.inputingBlock = ^(NSString *text) {
        if([weakself.startNum.text intValue] <= 0){
            weakself.startNum.placeholder = @"请输入起始数字";
        }else{
            weakself.startNum.placeholder = @"起始数字";
        }
    };
    
    weakself.endNum.placeholder = @"请输入终止数字";
    weakself.endNum.inputType = NMEFloatFieldInputTypeNum;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"HDDEndNumber"]){
        weakself.endNum.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"HDDEndNumber"];
    }
    weakself.endNum.inputingBlock = ^(NSString *text) {
        if([weakself.endNum.text intValue] <= 0){
            weakself.endNum.placeholder = @"请输入终止数字";
        }else{
            weakself.endNum.placeholder = @"终止数字";
        }
    };
    weakself.endNum.finishInputBlock = ^(NSString *text) {
        [[NSUserDefaults standardUserDefaults] setObject:text forKey:@"HDDEndNumber"];
    };
    
    weakself.num.placeholder = @"请输产生个数";
    weakself.num.text = @"1";
    weakself.num.inputType = NMEFloatFieldInputTypeNum;
    weakself.num.inputingBlock = ^(NSString *text) {
        if([weakself.num.text intValue] <= 0){
            weakself.num.placeholder = @"请输产生个数";
        }else{
            weakself.num.placeholder = @"产生个数";
        }
    };
    
    self.recordLab.numberOfLines = 0;
    self.recordLab.lineBreakMode = NSLineBreakByTruncatingHead; //前面的内容以……方式省略，显示头尾的文字内容。
    self.recordLab.adjustsFontSizeToFitWidth = YES; //动态调整label字体大小
    self.recordLab.minimumScaleFactor = 0.2; //设置最小字体大小
    
    self.resultLab.text = @"";
    self.resultLab.numberOfLines = 0;
    self.resultLab.lineBreakMode = NSLineBreakByTruncatingHead;
    self.resultLab.adjustsFontSizeToFitWidth = YES;
    self.resultLab.minimumScaleFactor = 0.3;
    

}
- (IBAction)productNumberClick:(id)sender {
    
    [self.startNum resignFirstResponder];
    [self.endNum resignFirstResponder];
    [self.num resignFirstResponder];
    
    self.resultLab.text = @"";
    UITextField *Field1 = self.startNum;
    UITextField *Field2 = self.endNum;
    UITextField *Field3 = self.num;
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
    
    if(int2-int1+1<int3 && self.isRepetitionSW.isOn == NO){
        [self showToast:@"这样会崩的老戴！！"];
        return;
    }

    if(!_rondomNum){
        _rondomNum  = [[RondomNumHelper alloc] init];
    }
    
    _str = @"";
    _strOrder = @"";
    if(int3 == 1){
        int num = [_rondomNum randFrom:int1 to:int2];
        sum = num;
        _str =[NSString stringWithFormat:@"%d", num];
        _strOrder =_str;
    }else{
        sum = 0;
        _arr = [_rondomNum getRandomArrayform:int1 To:int2 num:int3 isCover:self.isRepetitionSW.isOn];
        _arrMut = [NSMutableArray arrayWithArray:_arr];
        [_arrMut sortUsingSelector:@selector(compare:)];
        
        for(int i = 0; i < _arr.count; i++) {
            
            sum = sum + [_arr[i] intValue];
            _str = [_str stringByAppendingString:[NSString stringWithFormat:@" %@",_arr[i]]];
            _strOrder = [_strOrder stringByAppendingString:[NSString stringWithFormat:@"  %@",_arrMut[i]]];
        }
        
       
    }
    if(self.isOrderSW.isOn){
        self.resultLab.text = _strOrder;
    }else{
        self.resultLab.text = _str;
    }
    
    //合计结果
    UITextField *Field5 = [self.view viewWithTag:2005];
    Field5.text = [NSString stringWithFormat:@"%ld",sum];
    
    //记录
    if(self.isSaveSW.isOn){
        NSString *currStr = [NSString stringWithFormat:@"<%@ >",self.resultLab.text];
        _strRecord = [_strRecord stringByAppendingString:@" "];
        _strRecord = [_strRecord stringByAppendingString:currStr];
    }
    self.recordLab.text = _strRecord;
    self.clearBtn.hidden = !self.recordLab.text.length;
    
}
- (IBAction)clearClick:(id)sender {
    
    _strRecord = @"";
    self.recordLab.text = _strRecord;
    self.clearBtn.hidden = !self.recordLab.text.length;

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.startNum resignFirstResponder];
    [self.endNum resignFirstResponder];
    [self.num resignFirstResponder];

}

-(void) showToast:(NSString *) toastStr{
    [self.view makeToast:toastStr duration:1 position:CSToastPositionCenter];
}

@end
