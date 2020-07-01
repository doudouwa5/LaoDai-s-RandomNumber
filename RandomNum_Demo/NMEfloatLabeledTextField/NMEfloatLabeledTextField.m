//
//  NMEfloatLabeledTextField.m
//  NMEfloatLabeledTextField
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013-2015 Jared Verdi
//  Original Concept by Matt D. Smith
//  http://dribbble.com/shots/1254439--GIF-Mobile-Form-Interaction?list=users
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#define NUM @"0123456789"
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define ALPHANUMTHAI @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789๑๒๓๔๕๖๗๘๙ฎฑธณฯญฐฤฆฏโฌษศซฅฉฮฒฬฦๅภถคตจขชๆไพะรนยบลฟหกดเาสวงฃผปแอทมใฝ ู ํ ๊ ็ ๋ ฺ ์ ำ ุ ึ ั ี ้ ่ ิ ื "

#import "NMEfloatLabeledTextField.h"
#import "NSString+TextDirectionality.h"
#import "UITextField+ExtentionSetEyeBtn.h"
#import "NSString+FormattedString.h"

static CGFloat const kFloatingLabelShowAnimationDuration = 0.3f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.3f;

@interface NMEfloatLabeledTextField()<UITextFieldDelegate>

@end

@implementation NMEfloatLabeledTextField
{
    BOOL _isFloatingLabelFontDefault;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
    /*
     *
     * 提出来的hd2
     *
     */
    self.keepBaseline = NO; //yes时字体默认向下偏移
    self.clearButtonMode = UITextFieldViewModeWhileEditing;

    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.delegate = self;
    self.returnKeyType = UIReturnKeyDone;
    self.font = [UIFont systemFontOfSize:15];
    self.floatingLabelFont = [UIFont systemFontOfSize:13];
    self.floatingLabelYPadding = 8;
    if(!self.placeholderColor){
        self.placeholderColor = [UIColor colorWithHexString:@"#C4C4CB"];
    }
    if(!self.floatingLabelInputtingTextColor){
        self.floatingLabelInputtingTextColor = [HDDColor darkOrangeColor];
    }
    
    //
    _floatingLabel = [UILabel new];
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
	
    // some basic default fonts/colors
    _floatingLabelReductionRatio = 70;
    _floatingLabelFont = [self defaultFloatingLabelFont];
    _floatingLabel.font = _floatingLabelFont;
    _floatingLabelTextColor = [HDDColor commonTextGrayColor];
    _floatingLabel.textColor = _floatingLabelTextColor;
    _animateEvenIfNotFirstResponder = NO;
    _floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    _floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    [self setFloatingLabelText:self.placeholder];

    _adjustsClearButtonRect = YES;
    _isFloatingLabelFontDefault = YES;
}

#pragma mark -

- (UIFont *)defaultFloatingLabelFont
{
    UIFont *textFieldFont = nil;
    
    if (!textFieldFont && self.attributedPlaceholder && self.attributedPlaceholder.length > 0) {
        textFieldFont = [self.attributedPlaceholder attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont && self.attributedText && self.attributedText.length > 0) {
        textFieldFont = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
    }
    if (!textFieldFont) {
        textFieldFont = self.font;
    }
    
//    return [UIFont fontWithName:textFieldFont.fontName size:roundf(textFieldFont.pointSize * (_floatingLabelReductionRatio/100))];
    
    return [UIFont systemFontOfSize:roundf(textFieldFont.pointSize * (_floatingLabelReductionRatio/100))];
}

- (void)updateDefaultFloatingLabelFont
{
    UIFont *derivedFont = [self defaultFloatingLabelFont];
    
    if (_isFloatingLabelFontDefault) {
        self.floatingLabelFont = derivedFont;
    }
    else {
        // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
        _floatingLabelFont = derivedFont;
    }
}

- (UIColor *)labelActiveColor
{
    if (_floatingLabelInputtingTextColor) {
        return _floatingLabelInputtingTextColor;
    }else if(_floatingLabelTextColor){
        return _floatingLabelTextColor;
    }
//    else if ([self respondsToSelector:@selector(tintColor)]) {
//        return [self performSelector:@selector(tintColor)];
//    }
//    hd2
    return [HDDColor commonTextGrayColor];
}

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont
{
    if (floatingLabelFont != nil) {
        _floatingLabelFont = floatingLabelFont;
    }
    _floatingLabel.font = _floatingLabelFont ? _floatingLabelFont : [self defaultFloatingLabelFont];
    _isFloatingLabelFontDefault = floatingLabelFont == nil;
    [self invalidateIntrinsicContentSize];
}

-(void)setFloatingLabelYPadding:(CGFloat)floatingLabelYPadding{
    _floatingLabelYPadding = floatingLabelYPadding;
    [self setNeedsLayout];
}


- (void)showFloatingLabel:(BOOL)animated
{
    void (^showBlock)(void) = ^{
        self->_floatingLabel.alpha = 1.0f;
        self->_floatingLabel.frame = CGRectMake(self->_floatingLabel.frame.origin.x,
                                          self->_floatingLabelYPadding,
                                          self->_floatingLabel.frame.size.width,
                                          self->_floatingLabel.frame.size.height);
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelShowAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated
{
    void (^hideBlock)(void) = ^{
        self->_floatingLabel.alpha = 0.0f;
        self->_floatingLabel.frame = CGRectMake(self->_floatingLabel.frame.origin.x,
                                          self->_floatingLabel.font.lineHeight + self->_placeholderYPadding,
                                          self->_floatingLabel.frame.size.width,
                                          self->_floatingLabel.frame.size.height);

    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelHideAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

- (void)setLabelOriginForTextAlignment
{
    CGRect textRect = [self textRectForBounds:self.bounds];
    
    CGFloat originX = textRect.origin.x;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        originX = textRect.origin.x + (textRect.size.width/2) - (_floatingLabel.frame.size.width/2);
    }
    else if (self.textAlignment == NSTextAlignmentRight) {
        originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
    }
    else if (self.textAlignment == NSTextAlignmentNatural) {
        JVTextDirection baseDirection = [_floatingLabel.text getBaseDirection];
        if (baseDirection == JVTextDirectionRightToLeft) {
            originX = textRect.origin.x + textRect.size.width - _floatingLabel.frame.size.width;
        }
    }
    
    _floatingLabel.frame = CGRectMake(originX + _floatingLabelXPadding, _floatingLabel.frame.origin.y,
                                      _floatingLabel.frame.size.width, _floatingLabel.frame.size.height);
}

- (void)setFloatingLabelText:(NSString *)text
{
    _floatingLabel.text = text;
    [self setNeedsLayout];
}

#pragma mark - UITextField

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self updateDefaultFloatingLabelFont];
}

- (void)setFloatingLabelReductionRatio:(CGFloat)floatingLabelReductionRatio
{
  _floatingLabelReductionRatio = floatingLabelReductionRatio;
  _floatingLabelFont = [self defaultFloatingLabelFont];
  _floatingLabel.font = _floatingLabelFont;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self updateDefaultFloatingLabelFont];
}

- (CGSize)intrinsicContentSize
{
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [_floatingLabel sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + _floatingLabelYPadding + _floatingLabel.bounds.size.height);
}

- (void)setCorrectPlaceholder:(NSString *)placeholder
{
    if (self.placeholderColor && placeholder) {
        NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                                    attributes:@{NSForegroundColorAttributeName: self.placeholderColor}];
        [super setAttributedPlaceholder:attributedPlaceholder];
    } else {
        [super setPlaceholder:placeholder];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [self setCorrectPlaceholder:placeholder];
    [self setFloatingLabelText:placeholder];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder
{
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setFloatingLabelText:attributedPlaceholder.string];
    [self updateDefaultFloatingLabelFont];
}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle
{
    if(!placeholder.length){
        placeholder = floatingTitle;
    }
    if(!floatingTitle.length){
        floatingTitle = placeholder;
    }
    [self setCorrectPlaceholder:placeholder];
    [self setFloatingLabelText:floatingTitle];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder floatingTitle:(NSString *)floatingTitle
{
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setFloatingLabelText:floatingTitle];
}

- (void)setPlaceholderColor:(UIColor *)color
{
    _placeholderColor = color;
    [self setCorrectPlaceholder:self.placeholder];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

- (CGRect)insetRectForBounds:(CGRect)rect
{
    CGFloat topInset = ceilf(_floatingLabel.bounds.size.height + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    return CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds
{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    // for when there is no floating title label text
    if (0 != self.adjustsClearButtonRect && _floatingLabel.text.length )
    {
        if ([self.text length] || self.keepBaseline) {
            CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
            topInset = MIN(topInset, [self maxTopInset]);
            rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
        }
    }
    return CGRectIntegral(rect);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect rect = [super leftViewRectForBounds:bounds];
    
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    
    return rect;
}

//- (CGRect)rightViewRectForBounds:(CGRect)bounds
//{
//    
//    CGRect rect = [super rightViewRectForBounds:bounds];
//    
//    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
//    topInset = MIN(topInset, [self maxTopInset]);
//    rect = CGRectOffset(rect, 0, topInset / 2.0f);
//    
//    return rect;
//}

- (CGFloat)maxTopInset
{
    return MAX(0, floorf(self.bounds.size.height - self.font.lineHeight - 4.0f));
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsLayout];
}

- (void)setAlwaysShowFloatingLabel:(BOOL)alwaysShowFloatingLabel
{
    _alwaysShowFloatingLabel = alwaysShowFloatingLabel;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setLabelOriginForTextAlignment];
    
    CGSize floatingLabelSize = [_floatingLabel sizeThatFits:_floatingLabel.superview.bounds.size];
    
    _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                      _floatingLabel.frame.origin.y,
                                      floatingLabelSize.width,
                                      floatingLabelSize.height);
    
    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ? self.labelActiveColor : self.floatingLabelTextColor);
    if ((!self.text || 0 == [self.text length]) && !self.alwaysShowFloatingLabel) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
}

- (void)drawRect:(CGRect)rect {
    UIColor *lineColor = self.lineColor ? self.lineColor : [UIColor clearColor];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, lineColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 1.0, CGRectGetWidth(self.frame), 1));
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.inputType == NMEFloatFieldInputTypePhoneNum) {
        // 111 111 1111
        if ([string isEqualToString:@""]) { // 删除字符
            if (textField.text.length == 5 || textField.text.length == 9) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
            
        }else{
            if (textField.text.length == 3 || textField.text.length == 7 ) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
                
            }
        }
        return YES;
    }
    
    else if(self.inputType == NMEFloatFieldInputTypeCardNo){
        // 1111 1111 1111 1111
        if ([string isEqualToString:@""]) { // 删除字符
            if (textField.text.length == 6 || textField.text.length == 11 || textField.text.length == 16) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
            
        }else{
            if (textField.text.length == 4 || textField.text.length == 9 || textField.text.length == 14) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
        }
        return YES;
    }
    
    else if(self.inputType == NMEFloatFieldInputTypeCitizenID){
        // 1 2343 22231 256
        if ([string isEqualToString:@""]) { // 删除字符
            if (textField.text.length == 3 || textField.text.length == 8 || textField.text.length == 14) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
            
        }else{
            if (textField.text.length == 1 || textField.text.length == 6 || textField.text.length == 12) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
        }
        return YES;
    }
    
    else if(self.inputType == NMEFloatFieldInputTypeBankAccount){
        // 234-2-984053
        if ([string isEqualToString:@""]) { // 删除字符
            if (textField.text.length == 5 || textField.text.length == 7) {
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
            
        }else{
            if (textField.text.length == 3 || textField.text.length == 5) {
                textField.text = [NSString stringWithFormat:@"%@-", textField.text];
            }
        }
        return YES;
    }
    
    else if(self.inputType == NMEFloatFieldInputTypeName){
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ALPHANUMTHAI] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
    
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if(self.inputType == NMEFloatFieldInputTypePhoneNum){
        if (textField.text.length > 11) {
            if(textField.text.length > 12){
                self.text = [textField.text substringToIndex:12];
            }
            [self resignFirstResponder];
        }
    }
    else if(self.inputType == NMEFloatFieldInputTypeCardNo){
        if (textField.text.length > 18) {
            if(textField.text.length > 19){
                self.text = [textField.text substringToIndex:19];
            }
            [self resignFirstResponder];
        }
    }
    else if(self.inputType == NMEFloatFieldInputTypePIN){
        // ******
        if (textField.text.length > 5) {
            if(textField.text.length > 6){
                self.text = [textField.text substringToIndex:6];
            }
            [self resignFirstResponder];
        }
    }
    
    else if(self.inputType == NMEFloatFieldInputTypeCitizenID){
        // ******
        if (textField.text.length > 15) {
            if(textField.text.length > 16){
                self.text = [textField.text substringToIndex:16];
            }
            [self resignFirstResponder];
        }
    }
    
    else if(self.inputType == NMEFloatFieldInputTypeBankAccount){
        // ******
        if (textField.text.length > 11) {
            if(textField.text.length > 12){
                self.text = [textField.text substringToIndex:12];
            }
            [self resignFirstResponder];
        }
    }
    
    else if(self.inputType == NMEFloatFieldInputTypePostCode){
        // ******
        if (textField.text.length > 4) {
            if(textField.text.length > 5){
                self.text = [textField.text substringToIndex:5];
            }
            [self resignFirstResponder];
        }
    }
    
    
    //最大输入限制
    if(textField.text.length > self.maxChars - 1){
        if(textField.text.length > self.maxChars){
            self.text = [textField.text substringToIndex:self.maxChars];
        }
        [self resignFirstResponder];
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(self.inputingBlock){
            self.inputingBlock(self.text);
        }
    });

    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (self.finishInputBlock) {
        self.finishInputBlock(textField.text);
    }
}

-(void)setInputType:(NMEFloatFieldInputType)inputType{
    _inputType = inputType;
    if(inputType == NMEFloatFieldInputTypeCardNo || inputType == NMEFloatFieldInputTypeNum || inputType == NMEFloatFieldInputTypePIN || inputType == NMEFloatFieldInputTypeCitizenID || inputType == NMEFloatFieldInputTypeBankAccount || inputType == NMEFloatFieldInputTypePostCode || inputType == NMEFloatFieldInputTypePhoneNum){
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
//    else if(inputType == NMEFloatFieldInputTypePhoneNum){
//        self.keyboardType = UIKeyboardTypePhonePad;
//    }
    else if (inputType == NMEFloatFieldInputTypePhoneNumAndPoint){
        self.keyboardType = UIKeyboardTypeDecimalPad;
    }
    else if(inputType == NMEFloatFieldInputTypeNumAndChars){
        self.keyboardType = UIKeyboardTypeASCIICapable;
    }else{
        self.keyboardType = UIKeyboardTypeDefault;
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}

//#pragma mark - 禁用粘贴功能
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    UIMenuController *menuController = [UIMenuController sharedMenuController];
//    if (menuController) {
//        [UIMenuController sharedMenuController].menuVisible = NO;
//    }
//    return NO;
//}
#pragma mark - 禁用粘贴功能(部分)
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    // 粘贴功能
    if (action == @selector(paste:))
        return NO;
    // 选择功能
    if (action == @selector(select:))
        return YES;
    // 全选功能
    if (action == @selector(selectAll:))
        return YES;
    return [super canPerformAction:action withSender:sender];
}
@end

