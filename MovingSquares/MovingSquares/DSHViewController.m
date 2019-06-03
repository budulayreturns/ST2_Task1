//
//  DSHViewController.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHViewController.h"


@interface DSHViewController () <DSHCustomViewCreationProtocol, DSHCustomViewPositionChangeProtocol>

@end

@implementation DSHViewController

static NSString *kDisplayTitle = @"Moving Square";

#pragma mark - Lifestyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDisplayTitleName:kDisplayTitle];
    [self.view setBackgroundColor:[UIColor grayColor]];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(showScrollViewController)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    [self createTapGestureToSetDefaultTitle];
}

#pragma mark - Custom accessories

- (void)setDisplayTitleName:(NSString *)name {
    if (![self.title isEqualToString:name]) {
        [self setTitle:name];
    }
}

#pragma mark - Actions

- (void)tapGestureToView {
    [self setDisplayTitleName:kDisplayTitle];
}

- (void)tapGestureFrom:(UIGestureRecognizer *)sender {
    if(sender.view){
        if([sender.view isMemberOfClass:[DSHCustomView class]]) {
            [self setDisplayTitleName:((DSHCustomView*)sender.view).urlDescription];
        }
        
    }
}

- (void)showScrollViewController {
    DSHScrollViewController *svc = [[DSHScrollViewController alloc] initWithNibName:@"DSHScrollViewController" bundle:nil];
    if (svc) {
        svc.delegate = self;
        [self.navigationController pushViewController:svc animated:YES];
    }
}

#pragma mark - Private methods

- (void)createTapGestureToSetDefaultTitle {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureToView)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)createTapGestureTo:(DSHCustomView *)view {
    if (view) {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureFrom:)];
        [view addGestureRecognizer:tapGesture];
    }
}

- (void)setWidth:(CGFloat)width height:(CGFloat)height to:(DSHCustomView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [view.widthAnchor constraintEqualToConstant:width],
                                              [view.heightAnchor constraintEqualToConstant:height],
                                              ]];
}

- (void)setConstantX:(CGFloat)constantX constantY:(CGFloat)constantY to:(DSHCustomView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:constantX],
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:constantY]
                                              ]];
}

- (void)removeCenterXYConstraintsFrom:(DSHCustomView *)view {
    __weak DSHViewController *weakSelf = self;
    [self.view.constraints enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLayoutConstraint *constraint = (NSLayoutConstraint *)obj;
        if (constraint.firstItem == view || constraint.secondItem == view) {
            [weakSelf.view removeConstraint:constraint];
        }
    }];
    [self.view updateConstraintsIfNeeded];
}


#pragma mark - Protocol conformance

- (void)didCustomViewChanged:(DSHCustomView *)view {
    [self removeCenterXYConstraintsFrom:view];
    [self setConstantX:view.center.x - self.view.center.x constantY:view.center.y - self.view.center.y to:view];
}

- (void)createDSHCustomViewWithImageName:(NSString *)imageName urlDescription:(NSString *)urlDescription {
    UIImage *image = [UIImage imageNamed:imageName];
    image.accessibilityIdentifier = imageName;
    [self setDisplayTitleName:urlDescription];
    DSHCustomView *view = [[DSHCustomView alloc]initWithImage:image description:urlDescription];
    view.delegate = self;
    view.userInteractionEnabled = YES;
    view.textHidden = YES;
    view.draggingEnabled = YES;
    [self createTapGestureTo:view];
    [self.view addSubview:view];
    [self setWidth:130.0 height:100.0 to:view];
    [self setConstantX:0 constantY:0 to:view];
}

@end
