//
//  DSHScrollViewController.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHScrollViewController.h"
#import "DSHViewController.h"

@interface DSHScrollViewController ()
@property (nonatomic, strong) NSDictionary *imagePathsDictionary;
@end

@implementation DSHScrollViewController

static NSString *kDisplayTitle = @"Select Item";

- (NSDictionary *) getImageDataDictionary {
    return @{
             @0:@"https://loremflickr.com/320/240/0",
             @1:@"https://loremflickr.com/320/240/1",
             @2:@"https://loremflickr.com/320/240/2",
             @3:@"https://loremflickr.com/320/240/3",
             @4:@"https://loremflickr.com/320/240/4",
             @5:@"https://loremflickr.com/320/240/5",
             @6:@"https://loremflickr.com/320/240/6",
             @7:@"https://loremflickr.com/320/240/7",
             @8:@"https://loremflickr.com/320/240/8",
             @9:@"https://loremflickr.com/320/240/9",
             @10:@"https://loremflickr.com/320/240/10",
             @11:@"https://loremflickr.com/320/240/11",
             @12:@"https://loremflickr.com/320/240/12",
             @13:@"https://loremflickr.com/320/240/13",
             @14:@"https://loremflickr.com/320/240/14",
             @15:@"https://loremflickr.com/320/240/15",
             @16:@"https://loremflickr.com/320/240/16",
             @17:@"https://loremflickr.com/320/240/17",
             @18:@"https://loremflickr.com/320/240/18",
             @19:@"https://loremflickr.com/320/240/19",
             @20:@"https://loremflickr.com/320/240/20",
             @21:@"https://loremflickr.com/320/240/21",
             @22:@"https://loremflickr.com/320/240/22",
             @23:@"https://loremflickr.com/320/240/23",
             @24:@"https://loremflickr.com/320/240/24",
             @25:@"https://loremflickr.com/320/240/25",
             @26:@"https://loremflickr.com/320/240/26",
             @27:@"https://loremflickr.com/320/240/27",
             @28:@"https://loremflickr.com/320/240/28",
             @29:@"https://loremflickr.com/320/240/29",
             };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagePathsDictionary = [self getImageDataDictionary];
    [self setTitle:kDisplayTitle];
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(tapToCloseButton)];
    self.navigationItem.rightBarButtonItem = closeButtonItem;
    self.navigationItem.hidesBackButton = YES;
    [self addDSHCCustomViews];
    
}

- (void) addDSHCCustomViews {
    for (NSNumber *key in self.imagePathsDictionary.allKeys) {
        UIImage *image = [UIImage imageNamed:[key stringValue]];
        image.accessibilityIdentifier = [key stringValue];
        DSHCustomView *view = [self createDSHCustomViewWithImage:image andUrlDescriprion:self.imagePathsDictionary[key]];
        [self.scrollView addSubview:view];
    }
}

- (DSHCustomView*) createDSHCustomViewWithImage: (UIImage*) image andUrlDescriprion:(NSString*) urlDescription {
    DSHCustomView *view = [[DSHCustomView alloc]initWithImage:image andDescription:urlDescription];
    view.userInteractionEnabled = YES;
    [view setBackgroundColor:[UIColor redColor]];
    [self addTapGestureToDSHCCustomView:view];
    [self addUILabelToDSHCustomView:view];
    return view;
}

- (void) addUILabelToDSHCustomView: (DSHCustomView*) view{
    if (view) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 1;
        label.textColor = [UIColor whiteColor];
        label.text = view.urlDescription;
        [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                               forAxis:UILayoutConstraintAxisHorizontal];
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumScaleFactor = .5f;
        [view addSubview:label];
        [self setConstraintsToUILabel:label inDSHCustomView:view];
    }
}


- (void) addTapGestureToDSHCCustomView: (DSHCustomView *) view {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(tapGestureToDSHCustomView:)];
    [view addGestureRecognizer:tapGesture];
}

- (void) tapGestureToDSHCustomView: (UIGestureRecognizer*) sender {
    if (sender.view) {
        if ([sender.view isMemberOfClass:[DSHCustomView class]]){
            __weak DSHScrollViewController *selfWeak = self;
            [self closeDSHScrollViewController:^{
                NSLog(@"%@", selfWeak.navigationController.viewControllers);
                [selfWeak.delegate createDSHCustomViewWithImageName:((DSHCustomView*)sender.view).image.accessibilityIdentifier andUrlDescription:((DSHCustomView*) sender.view).urlDescription];
            }];
        }
    }
}

- (void) tapToCloseButton {
    [self closeDSHScrollViewController:nil];
}

- (void) closeDSHScrollViewController: (void (^)(void)) completion {
    [self.navigationController popViewControllerAnimated:YES];
    if (completion) {
        completion();
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setUIScrollViewConstraints];
}

- (void) setConstraintsToUILabel: (UILabel*) label inDSHCustomView: (DSHCustomView*) view {
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [label.leadingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.leadingAnchor],
                                              [label.trailingAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.trailingAnchor],
                                              [label.bottomAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.bottomAnchor constant:-8.0]
                                              ]];
    [label layoutIfNeeded];
}

- (void) setConstraintsToDSHCustomView: (DSHCustomView*) view inUIScrollView: (UIScrollView*) scrollView andHeight: (CGFloat) height {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [view.centerXAnchor constraintEqualToAnchor:scrollView.centerXAnchor],
                                              [view.widthAnchor constraintEqualToConstant:((DSHCustomView*)view).image.size.width],
                                              [view.heightAnchor constraintEqualToConstant:((DSHCustomView*)view).image.size.height],
                                              [view.topAnchor constraintEqualToAnchor: scrollView.topAnchor constant:height]
                                              ]];
    [view layoutIfNeeded];
}

- (void) setUIScrollViewConstraints {
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]]];
    [self.scrollView layoutIfNeeded];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat height = 8.0;
    CGFloat width = self.scrollView.frame.size.width;
    for (UIView *view in self.scrollView.subviews) {
        if ([view isMemberOfClass:[DSHCustomView class]]){
            [self setConstraintsToDSHCustomView:(DSHCustomView*)view inUIScrollView:self.scrollView andHeight:height];
            height += ((DSHCustomView*)view).image.size.height+8.0;
            width = ((DSHCustomView*)view).image.size.width > width ? ((DSHCustomView*)view).image.size.width : width;
        }
    }
    [self setDSHScrollViewContentWidth:width andHeight:height];
}


- (void) setDSHScrollViewContentWidth: (CGFloat) width andHeight: (CGFloat) height {
    self.scrollView.contentSize = CGSizeMake(width, height);
}

@end
