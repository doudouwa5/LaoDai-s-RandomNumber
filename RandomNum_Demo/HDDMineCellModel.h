//
//  HDDMineCellModel.h
//  RandomNum_Demo
//
//  Created by HanDD on 2020/7/2.
//  Copyright © 2020 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDMineCellModel : NSObject

@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *tittle;
@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) BOOL hiddenRightImage;

@end

NS_ASSUME_NONNULL_END
