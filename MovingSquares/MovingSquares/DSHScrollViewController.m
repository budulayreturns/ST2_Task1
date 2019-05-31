//
//  DSHScrollViewController.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHScrollViewController.h"

@interface DSHScrollViewController ()

@end

@implementation DSHScrollViewController

static NSString *kDisplayTitle = @"Select Item";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:kDisplayTitle];
    
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    UIBarButtonItem *closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeDSHScrollViewController)];
    self.navigationItem.rightBarButtonItem = closeButtonItem;
    self.navigationItem.hidesBackButton = YES;
}

- (void) closeDSHScrollViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
