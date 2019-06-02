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
@property (nonatomic, assign, getter=isDragging) BOOL dragging;
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


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Moved");
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {

        
        
    }
    
    NSLog(@"Child x:%f y:%f,",self.frame.origin.x, self.frame.origin.x);
    NSLog(@"Super x:%f y:%f,",touchLocation.x, touchLocation.y);
 
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
        NSLog(@"Touches began: %@", ((DSHCustomView*)touch.view).urlDescription);
        [self setDragging:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
        NSLog(@"Touches cancelled: %@", ((DSHCustomView*)touch.view).urlDescription);
        [self setDragging:NO];
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
        NSLog(@"Touches ended: %@", ((DSHCustomView*)touch.view).urlDescription);
        [self setDragging:NO];
    }
    [super touchesEnded:touches withEvent:event];
}

- (NSString*) urlDescription {
    return _urlDescription ? _urlDescription: @"undefined" ;
}

@end
