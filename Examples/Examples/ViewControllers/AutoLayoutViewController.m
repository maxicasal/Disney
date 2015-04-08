//
//  AutoLayoutViewController.m
//  Examples
//
//  Created by Nicolas on 4/8/15.
//  Copyright (c) 2015 Maximiliano Casal. All rights reserved.
//

#import "AutoLayoutViewController.h"

#define FIXED_HEIGHT_SMALL  100
#define FIXED_HEIGHT_BIG    200


@interface AutoLayoutViewController ()

@property (nonatomic, weak) IBOutlet UIView *redView;
@property (nonatomic, weak) IBOutlet UIView *yellowView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *yConstraint;
@property (nonatomic, assign) CGFloat firstYConstant;

@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstYConstant = self.yConstraint.constant;
}

- (IBAction)onHeight:(id)sender {

    //Here is an example to show how changing the height programmatically works. Both views have the constraint "height equal", thats why the animation is working on both views.
    
    self.heightConstraint.constant = (self.heightConstraint.constant == FIXED_HEIGHT_BIG) ? FIXED_HEIGHT_SMALL : FIXED_HEIGHT_BIG;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)onY:(id)sender {
    //Here we are animating the Y axis changing the constant of the constraint.

    self.yConstraint.constant = (self.yConstraint.constant == 0) ? self.firstYConstant : 0;
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
