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
- (void)didCustomViewChanged:(DSHCustomView* )view;
@end

@interface DSHCustomView : UIView
@property (nonatomic, copy, readonly) NSString *urlDescription;
@property (nonatomic, assign, getter=isDraggingEnabled) BOOL draggingEnabled;
@property (nonatomic, assign, getter=isTextHidden) BOOL textHidden;
@property (nonatomic, strong, readonly) UIImage *image;


@property (nonatomic, weak) id<DSHCustomViewPositionChangeProtocol> delegate;
- (instancetype)initWithImage:(UIImage*)image description:(NSString *)description;
@end

NS_ASSUME_NONNULL_END
