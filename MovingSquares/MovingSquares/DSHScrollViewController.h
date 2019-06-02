//
//  DSHScrollViewController.h
//  MovingSquares
//
//  Created by Дмитрий on 5/31/19.
//  Copyright © 2019 Dzmitry Shabailau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSHCustomView.h"


NS_ASSUME_NONNULL_BEGIN
@protocol DSHCustomViewCreationProtocol <NSObject>
- (void) createDSHCustomViewWithImageName: (NSString*) imageName andUrlDescription: (NSString*) urlDescription;
@end

@interface DSHScrollViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) id <DSHCustomViewCreationProtocol> delegate;
@end

NS_ASSUME_NONNULL_END
