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


- (instancetype)initWithImage:(UIImage*)image andDescription: (NSString*) description 
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _image = image;
        _urlDescription = description;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if (self.image) {
        [self.image drawInRect:self.bounds];
        
        //[self.image drawInRect:self.bounds];
        //self.contentMode = UIViewContentModeScaleAspectFill;
        //[self setNeedsDisplay];
        //[self sizeToFit];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Began");
    //[NSLayoutConstraint deactivateConstraints:@[]];
   NSLog(@"%@", self.constraints);
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Ended");
   
   // self.superview
    
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    touch locationInView:<#(nullable UIView *)#>
    NSLog(@"Moved");
    
    
//    [NSLayoutConstraint activateConstraints:@[
//                                              [self.centerXAnchor constraintEqualToAnchor:],
//                                              [self.centerYAnchor constraintEqualToAnchor:]
    
    
    
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Cancelled");
    [super touchesCancelled:touches withEvent:event];
}

- (NSString*) urlDescription {
    return _urlDescription ? _urlDescription: @"undefined" ;
}

@end
