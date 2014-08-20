//
//  Comment.m
//  Instagram
//
//  Created by Gustavo Parrado on 20/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Event.h"
#import <Parse/PFObject+Subclass.h>

@implementation Event

@dynamic type;
@dynamic origin;
@dynamic destination;
@dynamic details;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Event";
}
@end
