//
//  DSHCustomView.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHCustomView.h"

@interface DSHCustomView ()
@property (nonatomic,assign) BOOL shouldUpdateConstraints;
@property (nonatomic, strong, readwrite) UIImage *image;
@property (nonatomic, assign, getter=isDragging) BOOL dragging;
@property (nonatomic, assign) CGPoint oldTouchLocation;
@property (nonatomic, weak) UILabel *label;
@end

@implementation DSHCustomView

CGPoint oldPosition;


#pragma mark - Lifecycle

- (instancetype)initWithImage:(UIImage *)image description:(NSString *)description
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        UILabel *label = [[UILabel alloc]init];
        label.text = description;
        [self setup:label];
        [self addSubview:label];
        _label = label;
        _image = image;
        _draggingEnabled = NO;
        _textHidden = NO;
        _shouldUpdateConstraints = YES;
    }
    return self;
}

- (void)updateConstraints {
    [super updateConstraints];
    if (self.shouldUpdateConstraints) {
        [self setConstraintsToLabel];
        self.shouldUpdateConstraints = NO;
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.image) {
        [self.image drawInRect:self.bounds];
    }
}

#pragma mark - Custom accesories

- (NSString *)urlDescription {
    return self.label.text;
}

- (void) setTextHidden:(BOOL)textHidden {
    [self.label setHidden:textHidden];
}

#pragma mark - Actions

//- (void)tapGestureFrom:(UIGestureRecognizer *)sender {
//    if(sender.view){
//        if([sender.view isMemberOfClass:[DSHCustomView class]]) {
//            [self.delegate tapGestureFrom:sender];
//        }
//
//    }
//}

#pragma mark - Event handlers

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isDraggingEnabled]) {
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
            [self.delegate didCustomViewChanged:self];
        }
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isDraggingEnabled]) {
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
    if ([self isDraggingEnabled]) {
        UITouch *touch = [[event allTouches] anyObject];
        if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
            NSLog(@"Touch cancelled: %@", ((DSHCustomView*)touch.view).urlDescription);
            [self setDragging:NO];
        }
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self isDraggingEnabled]) {
        UITouch *touch = [[event allTouches] anyObject];
        if ([[touch.view class] isSubclassOfClass:[DSHCustomView class]]) {
            NSLog(@"Touch ended: %@", ((DSHCustomView*)touch.view).urlDescription);
            [self setDragging:NO];
        }
    }
    [super touchesEnded:touches withEvent:event];
}

#pragma mark - Private methods

- (void)setup:(UILabel *)label {
    if (label) {
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label.textColor = [UIColor whiteColor];
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                               forAxis:UILayoutConstraintAxisHorizontal];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = .5f;
    }
}

- (void)setConstraintsToLabel {
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.label.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor],
                                              [self.label.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor],
                                              [self.label.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-8.0]
                                              ]];
    [self layoutIfNeeded];
}

//- (void) addTapGesture {
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
//    [tapGesture addTarget:self action:@selector(tapGestureFrom:)];
//    [self addGestureRecognizer:tapGesture];
//}
@end
