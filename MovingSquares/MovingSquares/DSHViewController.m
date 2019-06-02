//
//  DSHViewController.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHViewController.h"


@interface DSHViewController () <DSHCustomViewCreationProtocol>

@end

@implementation DSHViewController

static NSString *kDisplayTitle = @"Moving Square";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDisplayTitleName:kDisplayTitle];
    [self.view setBackgroundColor:[UIColor grayColor]];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(showDSHScrollViewController)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
    [self createTapGestureToSetDefaultTitle];
}

- (void) setDisplayTitleName: (NSString*) name {
    if (![self.title isEqualToString:name]) {
        [self setTitle:name];
    }
}

- (void) showDSHScrollViewController {
    DSHScrollViewController *svc = [[DSHScrollViewController alloc] initWithNibName:@"DSHScrollViewController" bundle:nil];
    if (svc) {
        svc.delegate = self;
        [self.navigationController pushViewController:svc animated:YES];
    }
}

- (void) createTapGestureToSetDefaultTitle {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureToView)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void) tapGestureToView {
    [self setDisplayTitleName:kDisplayTitle];
}

- (void)createDSHCustomViewWithImageName:(NSString *)imageName andUrlDescription:(NSString *)urlDescription {
    UIImage *image = [UIImage imageNamed:imageName];
    image.accessibilityIdentifier = imageName;
    [self setDisplayTitleName:urlDescription];
    DSHCustomView *view = [[DSHCustomView alloc]initWithImage:image andDescription:urlDescription];
    view.userInteractionEnabled = YES;
    [self createTapGestureToDSHCustomView:view];
    [self.view addSubview:view];
    [self setConstraintsToDSHCustomView:view];
    
    //view.contentMode = UIViewContentModeScaleAspectFill;
    //[view setFrame:CGRectMake(self.view.center.x, self.view.center.y, view.image.size.width, view.image.size.height)];
    //[view setNeedsDisplay];
}

- (void) setConstraintsToDSHCustomView: (DSHCustomView*) view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [view.widthAnchor constraintEqualToConstant:130.0],
                                              [view.heightAnchor constraintEqualToConstant:100.0],
                                              [view.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [view.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
                                              ]];
}

- (void) createTapGestureToDSHCustomView: (DSHCustomView*) view {
    if (view) {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureToDSHCustomView:)];
        [view addGestureRecognizer:tapGesture];
    }
}

- (void) tapGestureToDSHCustomView: (UIGestureRecognizer*) sender {
    if(sender.view){
        if([sender.view isMemberOfClass:[DSHCustomView class]]) {
            [self setDisplayTitleName:((DSHCustomView*)sender.view).urlDescription];
        }
        
    }
}


@end
