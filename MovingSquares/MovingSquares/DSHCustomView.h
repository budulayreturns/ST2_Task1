//
//  DSHCustomView.h
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSHCustomView : UIView
@property (nonatomic, assign) BOOL draggingEnabled;
@property (nonatomic, strong, readonly) UIImage *image;
@property (nonatomic, copy, readonly) NSString *urlDescription;
- (instancetype)initWithImage:(UIImage*)image andDescription: (NSString*) description;
@end

NS_ASSUME_NONNULL_END
