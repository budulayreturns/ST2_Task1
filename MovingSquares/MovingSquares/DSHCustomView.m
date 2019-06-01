//
//  DSHCustomView.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHCustomView.h"

@interface DSHCustomView ()
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, copy, readwrite) NSString *urlDescription;
@property (nonatomic, strong, readwrite) UIImage *image;
@end

@implementation DSHCustomView


- (instancetype)initWithImage:(UIImage*)image andDescription: (NSString*) description //andPosition: (CGPoint) position
{
    self = [super initWithFrame:CGRectZero]; //CGRectMake(0, 0, image.size.width, image.size.height)];
    if (self) {
        _image = image;
        _urlDescription = description;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.image) {
        [self.image drawInRect:self.bounds];
        [self sizeToFit];
    }
}

- (NSString*) urlDescription {
    return _urlDescription ? _urlDescription: @"undefined" ;
}

@end
