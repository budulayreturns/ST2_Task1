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

#pragma mark - Lifecycle

- (instancetype)initWithImage:(UIImage *)image andDescription:(NSString *) description
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _image = image;
        _urlDescription = description;
        _draggingEnabled = NO;
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

#pragma mark - Custom accesories

- (NSString *)urlDescription {
    return _urlDescription ? _urlDescription: @"undefined" ;
}


#pragma mark - Event handlers

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self draggingEnabled]) {
        UITouch *touch = [[event allTouches] anyObject];
        if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
            NSLog(@"Touch moved: %@", ((DSHCustomView*)touch.view).urlDescription);
        }
        if (self.isDragging) {
            CGPoint touchLocation = [touch locationInView:self.superview];
            CGPoint newPoint = CGPointMake(self.center.x + (touchLocation.x - self.oldTouchLocation.x),
                                          self.center.y + (touchLocation.y - self.oldTouchLocation.y));
            self.center = CGPointMake(newPoint.x, newPoint.y);
            self.oldTouchLocation = [touch locationInView:self.superview];
            [self.delegate didDSHCustomViewChanged:self];
        }
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self draggingEnabled]) {
        UITouch *touch = [[event allTouches] anyObject];
        if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
            NSLog(@"Touch began: %@", ((DSHCustomView*)touch.view).urlDescription);
            self.oldTouchLocation = [touch locationInView:self.superview];
            [self setDragging:YES];
            [self.superview bringSubviewToFront:self];
        }
    }
    [super touchesBegan:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self draggingEnabled]) {
        UITouch *touch = [[event allTouches] anyObject];
        if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
            NSLog(@"Touch cancelled: %@", ((DSHCustomView*)touch.view).urlDescription);
            [self setDragging:NO];
        }
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self draggingEnabled]) {
        UITouch *touch = [[event allTouches] anyObject];
        if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
            NSLog(@"Touch ended: %@", ((DSHCustomView*)touch.view).urlDescription);
            [self setDragging:NO];
            //[self setupConstraints];
        }
    }
    [super touchesEnded:touches withEvent:event];
}

#pragma mark - Private methods



@end
