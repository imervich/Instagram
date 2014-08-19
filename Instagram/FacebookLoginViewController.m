//
//  FacebookLoginViewController.m
//  Instagram
//
//  Created by Iván Mervich on 8/19/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "FacebookLoginViewController.h"

#define showTabScreenSegue @"showTabScreenSegue"

@interface FacebookLoginViewController ()

@end

@implementation FacebookLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
}

@end
