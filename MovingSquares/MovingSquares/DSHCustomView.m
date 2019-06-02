//
//  DSHCustomView.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHCustomView.h"

@interface DSHCustomView ()
@property (nonatomic, copy, readwrite) NSString *urlDescription;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, assign, getter=isDragging) BOOL dragging;
@property (nonatomic, assign) CGPoint oldTouchLocation;
@end

@implementation DSHCustomView

CGPoint oldPosition;

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
        //self.contentMode = UIViewContentModeScaleAspectFill;
        //[self setNeedsDisplay];
        //[self sizeToFit];
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
//    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
//        NSLog(@"Touch moved: %@", ((DSHCustomView*)touch.view).urlDescription);
//    }
    if (self.isDragging) {
        CGPoint touchLocation = [touch locationInView:self.superview];
        CGPoint newPoint = CGPointMake(self.center.x + (touchLocation.x - self.oldTouchLocation.x),
                                      self.center.y + (touchLocation.y - self.oldTouchLocation.y));
        self.center = CGPointMake(newPoint.x, newPoint.y);
        self.oldTouchLocation = [touch locationInView:self.superview];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
        NSLog(@"Touch began: %@", ((DSHCustomView*)touch.view).urlDescription);
        //[self.superview bringSubviewToFront:self];
        self.oldTouchLocation = [touch locationInView:self.superview];
        [self setDragging:YES];
        [self removeDSHCustomViewConstraintsInSuperview];
        
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
        NSLog(@"Touch cancelled: %@", ((DSHCustomView*)touch.view).urlDescription);
        [self setDragging:NO];
        [self setupConstraints];
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
        NSLog(@"Touch ended: %@", ((DSHCustomView*)touch.view).urlDescription);
        [self setDragging:NO];
        [self setupConstraints];
    }
    [super touchesEnded:touches withEvent:event];
}

- (NSString*) urlDescription {
    return _urlDescription ? _urlDescription: @"undefined" ;
}

- (void) setupConstraints {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.centerXAnchor constraintEqualToAnchor:self.superview.centerXAnchor constant:self.center.x - self.superview.center.x],
                                              [self.centerYAnchor constraintEqualToAnchor:self.superview.centerYAnchor constant:self.center.y - self.superview.center.y]
                                              ]];
    [self layoutIfNeeded];
}

- (void) removeDSHCustomViewConstraintsInSuperview {
    __weak DSHCustomView* weakSelf = self;
    [self.superview.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint *constraint = (NSLayoutConstraint *)obj;
        if (constraint.firstItem == weakSelf || constraint.secondItem == weakSelf) {
            [self.superview removeConstraint:constraint];
        }
    }];
}

@end
