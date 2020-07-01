//
//  NMEButton.m
//  NearMerchant
//
//  Created by 韩豆豆 on 2019/4/23.
//  Copyright © 2019 qmm. All rights reserved.
//

#import "NMEButton.h"

IB_DESIGNABLE

@interface NMEButton ()

@property(nonatomic)IBInspectable float cornerRadius;

@property(nonatomic)IBInspectable BOOL hasBorder;


@end



@implementation NMEButton

-(instancetype)init{
    if (self = [super init]) {
        [self setBtnColor];
    }
    return self;
}

+ (Class)layerClass{
    return [CAGradientLayer class];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setBtnColor];
}

-(void) setBtnColor{

    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    layer.colors = @[(__bridge id)[HDDColor lightOrangeColor].CGColor,(__bridge id)[HDDColor darkOrangeColor].CGColor];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightBold]];
    [self setTitleColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0f alpha:0.2] forState:UIControlStateHighlighted];
    [self setAdjustsImageWhenHighlighted:YES];

}


-(void)setCornerRadius:(float)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}


-(void)setHasBorder:(BOOL)hasBorder{
    if (hasBorder) {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [HDDColor darkOrangeColor].CGColor;
    }
}

-(void)setIsCanClick:(BOOL)isCanClick{
    _isCanClick = isCanClick;
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    if(_isCanClick){
        self.userInteractionEnabled = YES;
        layer.colors = @[(__bridge id)[HDDColor lightOrangeColor].CGColor,(__bridge id)[HDDColor darkOrangeColor].CGColor];

    }else{
        self.userInteractionEnabled = NO;
        layer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#f3cfa6"].CGColor,(__bridge id)[UIColor colorWithHexString:@"#f3b18e"].CGColor];

    }
}


-(void) setBlueColor:(BOOL)blueColor{
    _blueColor = blueColor;
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    if(blueColor){
        layer.colors = @[(__bridge id)[HDDColor lightBlueColor].CGColor,(__bridge id)[HDDColor darkBlueColor].CGColor];
    }

}

-(void) setWhiteColor:(BOOL)whiteColor{
    _whiteColor = whiteColor;
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    if(whiteColor){
        layer.colors = @[(__bridge id)[HDDColor whiteColor].CGColor,(__bridge id)[HDDColor whiteColor].CGColor];
    }
    [self setTitleColor:[HDDColor darkOrangeColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithHexString:@"#FEE1CD"] forState:UIControlStateHighlighted];
    
}

@end
