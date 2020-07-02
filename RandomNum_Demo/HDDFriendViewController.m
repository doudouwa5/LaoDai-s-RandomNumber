//
//  HDDFriendViewController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDFriendViewController.h"

#define RATIO (0.2389)

@interface HDDFriendViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textKJ;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textCal;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textEveryKJ;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textWeight;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textHotThisFood;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textResult;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textOnlyOneNeed;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textNeedCal;
@property (weak, nonatomic) IBOutlet UILabel *tiplabel;

@end

@implementation HDDFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"热量转换器";
    
    [self setText];
}

-(void) setText{
    
    WeakSelf(self)
    weakself.textKJ.placeholder = @"千焦(kj)";
    weakself.textKJ.text = @"1";
    weakself.textKJ.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textKJ.inputingBlock = ^(NSString *text) {
        if([weakself.textKJ.text floatValue] >= 0){
            NSString *res = [NSString stringWithFormat:@"%0.4f ",RATIO * [weakself.textKJ.text floatValue]];
            res = [res stringByReplacingOccurrencesOfString:@".0000 " withString:@""];
            res = [res stringByReplacingOccurrencesOfString:@"000 " withString:@""];
            res = [res stringByReplacingOccurrencesOfString:@"00 " withString:@""];
            res = [res stringByReplacingOccurrencesOfString:@"0 " withString:@""];
            weakself.textCal.text = res;
        }else{
            weakself.textCal.placeholder = @"0";
        }
    };
    
    weakself.textCal.placeholder = @"卡路里(kcal)";
    weakself.textCal.text = [NSString stringWithFormat:@"%0.4f",RATIO];
    weakself.textCal.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textCal.inputingBlock = ^(NSString *text) {
        if([weakself.textCal.text floatValue] >= 0){
            NSString *res = [NSString stringWithFormat:@"%0.3f ",[weakself.textCal.text floatValue] / RATIO];
            res = [res stringByReplacingOccurrencesOfString:@".000 " withString:@""];
            res = [res stringByReplacingOccurrencesOfString:@"00 " withString:@""];
            res = [res stringByReplacingOccurrencesOfString:@"0 " withString:@""];

            weakself.textKJ.text = res;
        }else{
            weakself.textKJ.placeholder = @"0";
        }
    };

  
    weakself.textEveryKJ.placeholder = @"您食物中每100(g/ml)所含的热量(kj)";
    weakself.textEveryKJ.text = @"";
    weakself.textEveryKJ.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textEveryKJ.inputingBlock = ^(NSString *text) {
        [weakself checkNeedNum];
    };
    
    weakself.textWeight.placeholder = @"您当前食物的重量(g/ml)";
    weakself.textWeight.text = @"";
    weakself.textWeight.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textWeight.inputingBlock = ^(NSString *text) {
        [weakself checkNeedNum];

    };
    
    weakself.textNeedCal.placeholder = @"您需要吃掉的热量(kcal)";
    weakself.textNeedCal.text = @"";
    weakself.textNeedCal.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textNeedCal.inputingBlock = ^(NSString *text) {
        [weakself checkNeedNum];

    };
    
    weakself.textHotThisFood.placeholder = @"该食物的热量为";
    weakself.textHotThisFood.userInteractionEnabled = NO;
    weakself.textHotThisFood.text = @"";
    weakself.textHotThisFood.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textHotThisFood.inputingBlock = ^(NSString *text) {
    };
    
    weakself.textOnlyOneNeed.placeholder = @"如果吃一个这个食物的话，您还差";
    weakself.textOnlyOneNeed.userInteractionEnabled = NO;
    weakself.textOnlyOneNeed.text = @"";
    weakself.textOnlyOneNeed.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textOnlyOneNeed.inputingBlock = ^(NSString *text) {
    };
    
    weakself.textResult.placeholder = @"您大约要吃掉该食物";
    weakself.textResult.userInteractionEnabled = NO;
    weakself.textResult.text = @"";
    weakself.textResult.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textResult.inputingBlock = ^(NSString *text) {
    };
}


-(void) checkNeedNum{
    
    if([self.textEveryKJ.text floatValue] > 0 && [self.textWeight.text floatValue] > 0 ){
        float kj = [self.textEveryKJ.text floatValue] * [self.textWeight.text floatValue] / 100;
        NSString *htotStr = [NSString stringWithFormat:@"%0.4f kj    %0.4f kcal", kj, kj * RATIO];
        htotStr = [htotStr stringByReplacingOccurrencesOfString:@".0000 " withString:@""];
        htotStr = [htotStr stringByReplacingOccurrencesOfString:@"000 " withString:@""];
        htotStr = [htotStr stringByReplacingOccurrencesOfString:@"00 " withString:@""];
        htotStr = [htotStr stringByReplacingOccurrencesOfString:@"0 " withString:@""];
        self.textHotThisFood.text = htotStr;
    }
    
    if([self.textEveryKJ.text floatValue] > 0 && [self.textWeight.text floatValue] > 0 && [self.textNeedCal.text floatValue] > 0){
        
        NSString *tipstr = @"";
        double calOf100 = [self.textEveryKJ.text floatValue] * RATIO; //100g拥有的cal
        double neefOf100Cal = [self.textNeedCal.text floatValue] / calOf100;  //需要多少个这样的100g
        double result = neefOf100Cal / [self.textWeight.text floatValue] *100;
        
        if(result>1){
            double resultAddPoint5 = result + 0.5;
            
            if((int)result == (int)resultAddPoint5){
                tipstr = [NSString stringWithFormat:@"您大概要吃 %d 个(盒/袋等)还多一点的食物",(int)result];
            }else{
                tipstr = [NSString stringWithFormat:@"您大概要吃近 %d 个(盒/袋等)食物",(int)resultAddPoint5];
            }
        }else{
            if(result - 0.8 > 0){
                tipstr = [NSString stringWithFormat:@"您大概能吃不到 1 个(盒/袋等)食物"];
            }else if((result - 0.5 > 0)){
                tipstr = [NSString stringWithFormat:@"您大概能吃多半个(盒/袋等)食物"];
            }else if ((result - 0.3 > 0)){
                tipstr = [NSString stringWithFormat:@"您大概能吃少半个(盒/袋等)食物"];
            }else{
                tipstr = [NSString stringWithFormat:@"妈呀，你只能吃一点点"];
            }
        }
        
        float OneKj = [self.textEveryKJ.text floatValue] * [self.textWeight.text floatValue] / 100;
        float OneCal = [self.textEveryKJ.text floatValue] * [self.textWeight.text floatValue] / 100 * RATIO;
        float needKj = [self.textNeedCal.text floatValue] / RATIO;
        float needcal = [self.textNeedCal.text floatValue];
        float chaKj = needKj - OneKj;
        float chacal = needcal - OneCal;
        self.textOnlyOneNeed.text = [NSString stringWithFormat:@"%.2fkj  %.2fkcal",chaKj ,chacal];
        
        self.textResult.text = [NSString stringWithFormat:@"%.2f",result];
        self.tiplabel.text = tipstr;

    }else{
        self.textOnlyOneNeed.text = @"";
        self.textResult.text = @"";
        self.tiplabel.text = @"";
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [self.textKJ resignFirstResponder];
    [self.textCal resignFirstResponder];
    [self.textEveryKJ resignFirstResponder];
    [self.textWeight resignFirstResponder];
    [self.textResult resignFirstResponder];
    [self.textNeedCal resignFirstResponder];

}
@end
