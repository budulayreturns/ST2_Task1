//
//  DSHViewController.m
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import "DSHViewController.h"

@interface DSHViewController ()

@end

@implementation DSHViewController

static NSString *kDisplayTitle = @"Moving Square";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:kDisplayTitle];
    [self.view setBackgroundColor:[UIColor grayColor]];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                   target:self
                                                                                   action:@selector(showDSHListViewController)];
    self.navigationItem.rightBarButtonItem = addButtonItem;
}

- (void) showDSHListViewController {
    DSHScrollViewController *svc = [[DSHScrollViewController alloc] initWithNibName:@"DSHScrollViewController" bundle:nil];
    if (svc) {
        [self.navigationController pushViewController:svc animated:YES];
    }
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
