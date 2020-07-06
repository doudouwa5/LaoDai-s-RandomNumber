//
//  HDDFriendViewController.m
//  RandomNum_Demo
//
//  Created by HanDD on 2020/6/29.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import "HDDFriendViewController.h"

#define RATIO (0.2389)

@interface HDDFriendViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
{
    BOOL keyboardShown;
    UITextField *curTextField;
}
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textAllCal;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textAlreadyCal;
@property (weak, nonatomic) IBOutlet NMEfloatLabeledTextField *textChaCal;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
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
    
    [self setScrollView];
    [self setText];
    
    UITapGestureRecognizer *tapGr =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapGr];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr{
    [self.textAllCal resignFirstResponder];
    [self.textAlreadyCal resignFirstResponder];
    [self.textChaCal resignFirstResponder];

    [self.textKJ resignFirstResponder];
    [self.textCal resignFirstResponder];
    [self.textEveryKJ resignFirstResponder];
    [self.textWeight resignFirstResponder];
    [self.textResult resignFirstResponder];
    [self.textNeedCal resignFirstResponder];
}

-(void) setScrollView{
    self.scrollView.contentSize=self.view.bounds.size;//显示区域为图片的size，图片比手机屏幕大
    self.scrollView.contentOffset=CGPointZero;//开始的原点，前两个属性可以实现基本的scrollView
    self.scrollView.contentOffset=CGPointMake(0, 1000);//偏移量
    //self.scrollView.contentInset=UIEdgeInsetsMake(100, 100, 100, 0);//self.scrollView.contentInset=UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)拉出后弹簧效果弹回后会有一个边框的存在，上左下右分别边框多大多少
    //self.scrollView.bounces=NO;//默认是有弹簧效果的。设为NO后就不会有弹簧效果，拖动到可拖动的范围就不能 拖了。
    self.scrollView.showsHorizontalScrollIndicator=NO;//水平提示器，默认是有的
    self.scrollView.showsVerticalScrollIndicator=NO;//垂直提示器，默认是有的
}
- (IBAction)addCalClick:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入热量(kcal)" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //textField.placeholder = @"请输入。。。";
        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];
    
    WeakSelf(self)
    UIAlertAction *addAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *calfield = alert.textFields.firstObject;
        float alreadyCal = [weakself.textAlreadyCal.text floatValue];
        float nowCal = [calfield.text floatValue] + alreadyCal;
       
        NSString *nowStr = [NSString stringWithFormat:@"%0.4f ", nowCal];
        nowStr = [nowStr stringByReplacingOccurrencesOfString:@".0000 " withString:@""];
        nowStr = [nowStr stringByReplacingOccurrencesOfString:@"000 " withString:@""];
        nowStr = [nowStr stringByReplacingOccurrencesOfString:@"00 " withString:@""];
        nowStr = [nowStr stringByReplacingOccurrencesOfString:@"0 " withString:@""];
        weakself.textAlreadyCal.text = nowStr;
        [weakself checkChaNum];
    }];
    [alert addAction:addAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)clearCalClick:(id)sender {
    
    self.textAlreadyCal.text = @"";
    [self checkChaNum];
}


-(void) setText{
    
    WeakSelf(self)
    weakself.textAllCal.placeholder = @"您总共需要的热量(kcal)";
    weakself.textAllCal.text = @"";
    weakself.textAllCal.delegate = self;
    weakself.textAllCal.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textAllCal.inputingBlock = ^(NSString *text) {
        [weakself checkChaNum];
    };
    
    weakself.textAlreadyCal.placeholder = @"已经加入的热量";
    weakself.textAlreadyCal.text = @"";
    weakself.textAlreadyCal.delegate = self;
    weakself.textAlreadyCal.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textAlreadyCal.inputingBlock = ^(NSString *text) {
        [weakself checkChaNum];
    };
    
    weakself.textChaCal.placeholder = @"您还差的热量(kcal)";
    weakself.textChaCal.text = @"";
    weakself.textOnlyOneNeed.userInteractionEnabled = NO;
    weakself.textChaCal.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textChaCal.inputingBlock = ^(NSString *text) {
        [weakself checkChaNum];
    };
    
    
    weakself.textKJ.placeholder = @"千焦(kj)";
    weakself.textKJ.text = @"1";
    weakself.textAllCal.delegate = self;
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
    weakself.textCal.delegate = self;
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
    weakself.textEveryKJ.delegate = self;
    weakself.textEveryKJ.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textEveryKJ.inputingBlock = ^(NSString *text) {
        [weakself checkNeedNum];
    };
    
    weakself.textWeight.placeholder = @"您当前食物的重量(g/ml)";
    weakself.textWeight.text = @"";
    weakself.textWeight.delegate = self;
    weakself.textWeight.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textWeight.inputingBlock = ^(NSString *text) {
        [weakself checkNeedNum];

    };
    
    weakself.textNeedCal.placeholder = @"本次您需要吃掉的热量(kcal)";
    weakself.textNeedCal.text = @"";
    weakself.textNeedCal.delegate = self;
    weakself.textNeedCal.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textNeedCal.inputingBlock = ^(NSString *text) {
        [weakself checkNeedNum];

    };
    
    weakself.textHotThisFood.placeholder = @"该食物的热量为";
    weakself.textHotThisFood.userInteractionEnabled = NO;
    weakself.textHotThisFood.text = @"";
    weakself.textHotThisFood.delegate = self;
    weakself.textHotThisFood.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textHotThisFood.inputingBlock = ^(NSString *text) {
    };
    
    weakself.textOnlyOneNeed.placeholder = @"如果吃一个这个食物的话，您还差";
    weakself.textOnlyOneNeed.userInteractionEnabled = NO;
    weakself.textOnlyOneNeed.text = @"";
    weakself.textOnlyOneNeed.delegate = self;
    weakself.textOnlyOneNeed.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textOnlyOneNeed.inputingBlock = ^(NSString *text) {
    };
    
    weakself.textResult.placeholder = @"您大约要吃掉该食物";
    weakself.textResult.userInteractionEnabled = NO;
    weakself.textResult.text = @"";
    weakself.textResult.delegate = self;
    weakself.textResult.inputType = NMEFloatFieldInputTypePhoneNumAndPoint;
    weakself.textResult.inputingBlock = ^(NSString *text) {
    };
    
}


-(void) checkChaNum{
    float chaCal = 0;
    if([self.textAllCal.text floatValue] > 0){
        chaCal = [self.textAllCal.text floatValue] - [self.textAlreadyCal.text floatValue];
    }
    NSString *chaStr = [NSString stringWithFormat:@"%0.4f ", chaCal];
    chaStr = [chaStr stringByReplacingOccurrencesOfString:@".0000 " withString:@""];
    chaStr = [chaStr stringByReplacingOccurrencesOfString:@"000 " withString:@""];
    chaStr = [chaStr stringByReplacingOccurrencesOfString:@"00 " withString:@""];
    chaStr = [chaStr stringByReplacingOccurrencesOfString:@"0 " withString:@""];
    self.textChaCal.text = chaStr;
}

-(void) checkNeedNum{
    
    if([self.textEveryKJ.text floatValue] > 0 && [self.textWeight.text floatValue] > 0 ){
        float kj = [self.textEveryKJ.text floatValue] * [self.textWeight.text floatValue] / 100;
        NSString *htotStr = [NSString stringWithFormat:@"%0.4f (kj)    %0.4f (kcal)", kj, kj * RATIO];
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
        self.textOnlyOneNeed.text = [NSString stringWithFormat:@"%.2f(kj)   %.2f(kcal)",chaKj ,chacal];
        
        self.textResult.text = [NSString stringWithFormat:@"%.2f",result];
        self.tiplabel.text = tipstr;

    }else{
        self.textOnlyOneNeed.text = @"";
        self.textResult.text = @"";
        self.tiplabel.text = @"";
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.textResult.frame)+60)];
}


#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    curTextField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    curTextField = nil;
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.1 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height+60, 0);
    }];
    
    
    CGSize keyboardSize = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    float keyboardHeight = keyboardSize.height;
    float textFieldBottom = kScreenHeight - CGRectGetMaxY(curTextField.frame) + self.scrollView.contentOffset.y;
    if(textFieldBottom < keyboardHeight + 80 ){
        [UIView animateWithDuration:0.1 animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y + keyboardHeight + 80 - textFieldBottom);//偏移量
        }];
    }

    
    
//    if (keyboardShown)
//       return;
//
//    CGSize keyboardSize = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//
//    // Resize the scroll view (which is the root view of the window)
//
//    CGRect viewFrame = [self.scrollView frame];
//
//    viewFrame.size.height -= keyboardSize.height;
//
//    self.scrollView.frame = viewFrame;
//
//    // Scroll the active text field into view.
//    CGRect textFieldRect = [curTextField frame];
//
//    [self.scrollView scrollRectToVisible:textFieldRect animated:YES];
//    keyboardShown = YES;
    
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
//    [self.scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(self.textResult.frame)+60)];
    self.scrollView.contentInset = UIEdgeInsetsZero;

   
//    CGSize keyboardSize = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    // Reset the height of the scroll view to its original value
//
//    CGRect viewFrame = [self.scrollView frame];
//
//    viewFrame.size.height += keyboardSize.height;
//
//    self.scrollView.frame = viewFrame;
//    keyboardShown = NO;
}

#pragma mark scrollView delegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self viewTapped:nil];
}

@end
