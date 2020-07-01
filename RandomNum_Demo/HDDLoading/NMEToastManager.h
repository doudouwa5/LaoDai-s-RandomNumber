//
//  NMEToastEngine.h
//  NearMerchant
//
//  Created by 陈建国 on 2018/12/28.
//  Copyright © 2018 qmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMEPositionEnum.h"


NS_ASSUME_NONNULL_BEGIN

@interface NMEToastManager : UIView

+(void)showToastWith:(NSString *)title;

+(void)showToastWith:(NSString *)title position:(Position)position;

+(void)showLoading;

+(void)hiddenLoading;

@end

NS_ASSUME_NONNULL_END


NS_ASSUME_NONNULL_BEGIN

@interface NMETitleToast : NMEToastManager

@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN

@interface NMELoadingToast : NMEToastManager

@end

NS_ASSUME_NONNULL_END
