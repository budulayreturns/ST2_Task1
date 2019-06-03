//
//  DSHCustomView.h
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSHCustomView;

NS_ASSUME_NONNULL_BEGIN
@protocol DSHCustomViewPositionChangeProtocol<NSObject>
- (void)didDSHCustomViewChanged:(DSHCustomView* )view;
@end

@interface DSHCustomView : UIView
@property (nonatomic, assign) BOOL draggingEnabled;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy, readonly) NSString *urlDescription;
@property (nonatomic, weak) id<DSHCustomViewPositionChangeProtocol>delegate;
- (instancetype)initWithImage:(UIImage*)image andDescription:(NSString *)description;
@end

NS_ASSUME_NONNULL_END
