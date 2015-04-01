//
//  FruitDetailedViewController.m
//  BBC Test App
//
//  Created by Omer Janjua on 16/01/2015.
//  Copyright (c) 2015 Omer Janjua. All rights reserved.
//

#import "FruitDetailedViewController.h"

@interface FruitDetailedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;

@end

@implementation FruitDetailedViewController

-(void)viewWillAppear:(BOOL)animated
{
    CGFloat redLevel    = rand() / (float) RAND_MAX;
    CGFloat greenLevel  = rand() / (float) RAND_MAX;
    CGFloat blueLevel   = rand() / (float) RAND_MAX;
    
    self.view.backgroundColor = [UIColor colorWithRed: redLevel
                                             green: greenLevel
                                              blue: blueLevel
                                             alpha: 1.0];
    
    _priceLabel.text = [NSString stringWithFormat:@"Price: £%.2fp", [_price doubleValue]/100];
    _weightLabel.text = [NSString stringWithFormat:@"Weight: %.3fkg", [_weight doubleValue]/1000];
}

@end
