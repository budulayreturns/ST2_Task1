//
//  DSHScrollViewController.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHScrollViewController.h"

@interface DSHScrollViewController ()
@property (nonatomic, strong) NSArray <UIImage*> *imageArray;
@property (nonatomic, strong) NSDictionary *imagePathsDictionary;
@end

@implementation DSHScrollViewController

static NSString *kDisplayTitle = @"Select Item";

- (NSDictionary *) getImageDataDictionary {
    return @{
             @0:@"https://loremflickr.com/320/240",
             @1:@"https://loremflickr.com/320/240",
             @2:@"https://loremflickr.com/320/240",
             @3:@"https://loremflickr.com/320/240",
             @4:@"https://loremflickr.com/320/240",
             @5:@"https://loremflickr.com/320/240",
             @6:@"https://loremflickr.com/320/240",
             @7:@"https://loremflickr.com/320/240",
             @8:@"https://loremflickr.com/320/240",
             @9:@"https://loremflickr.com/320/240",
             @10:@"https://loremflickr.com/320/240",
             @11:@"https://loremflickr.com/320/240",
             @12:@"https://loremflickr.com/320/240",
             @13:@"https://loremflickr.com/320/240",
             @14:@"https://loremflickr.com/320/240",
             @15:@"https://loremflickr.com/320/240",
             @16:@"https://loremflickr.com/320/240",
             @17:@"https://loremflickr.com/320/240",
             @18:@"https://loremflickr.com/320/240",
             @19:@"https://loremflickr.com/320/240",
             @20:@"https://loremflickr.com/320/240",
             @21:@"https://loremflickr.com/320/240",
             @22:@"https://loremflickr.com/320/240",
             @23:@"https://loremflickr.com/320/240",
             @24:@"https://loremflickr.com/320/240",
             @25:@"https://loremflickr.com/320/240",
             @26:@"https://loremflickr.com/320/240",
             @27:@"https://loremflickr.com/320/240",
             @28:@"https://loremflickr.com/320/240",
             @29:@"https://loremflickr.com/320/240",
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePathsDictionary = [self getImageDataDictionary];
    [self setTitle:kDisplayTitle];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeDSHScrollViewController)];
    self.navigationItem.rightBarButtonItem = closeButtonItem;
    self.navigationItem.hidesBackButton = YES;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addDSHCCustomViews];
    
}

- (void) addDSHCCustomViews {
    for (NSNumber *key in self.imagePathsDictionary.allKeys) {
        UIImage *image = [UIImage imageNamed:[key stringValue]];
        DSHCustomView *view = [self createDSHCustomViewWithImage:image andUrlDescriprion:self.imagePathsDictionary[key]];
        [self.scrollView addSubview:view];
    }
}

- (DSHCustomView*) createDSHCustomViewWithImage: (UIImage*) image andUrlDescriprion:(NSString*) urlDescription {
    DSHCustomView *view = [[DSHCustomView alloc]initWithImage:image andDescription:urlDescription];
    [view setBackgroundColor:[UIColor redColor]];
    [self addTapGestureToDSHCCustomView:view];
    [self addUILabelToDSHCustomView:view];
    return view;
}

- (void) addUILabelToDSHCustomView: (DSHCustomView*) view{
    if (view) {
        UILabel *label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label.textColor = [UIColor whiteColor];
        label.text = view.urlDescription;
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                               forAxis:UILayoutConstraintAxisHorizontal];
       
        [view addSubview:label];
        [self setConstraintsToUILabel:label inDSHCustomView:view];
    }
}

- (void) setConstraintsToUILabel: (UILabel*) label inDSHCustomView: (DSHCustomView*) view {
    [NSLayoutConstraint activateConstraints:@[
                                              [label.leadingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.leadingAnchor],
                                              [label.trailingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.trailingAnchor],
                                              [label.bottomAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.bottomAnchor constant:-8.0]
                                              ]];
}


- (void) addTapGestureToDSHCCustomView: (DSHCustomView *) view {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGesture:)];
    [view addGestureRecognizer:tapGesture];
}

- (void) tapGesture: (id) sender {
    [self closeDSHScrollViewController];
}

- (void) closeDSHScrollViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setDSHScrollViewConstraints];
}

- (void) setDSHScrollViewConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]]];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat height = 8.0;
    for (UIView *view in self.scrollView.subviews) {
        if ([view isMemberOfClass:[DSHCustomView class]]){
            view.translatesAutoresizingMaskIntoConstraints = NO;
            
            [NSLayoutConstraint activateConstraints:@[
                                                      [view.centerXAnchor constraintEqualToAnchor:self.scrollView.centerXAnchor],
                                                      [view.widthAnchor constraintEqualToConstant:((DSHCustomView*)view).image.size.width],
                                                      [view.heightAnchor constraintEqualToConstant:((DSHCustomView*)view).image.size.height],
                                                      [view.topAnchor constraintEqualToAnchor: self.scrollView.topAnchor constant:height],
                                                      ]];
            height += ((DSHCustomView*)view).image.size.height+8.0;
        }
    }
    [self setDSHScrollViewContentWidth:self.scrollView.frame.size.width andHeight:height];
}


- (void) setDSHScrollViewContentWidth: (CGFloat) width andHeight: (CGFloat) height {
    self.scrollView.contentSize = CGSizeMake(width, height);
}

@end
