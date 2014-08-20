//
//  Comment.m
//  Instagram
//
//  Created by Gustavo Parrado on 20/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Comment.h"
#import <Parse/PFObject+Subclass.h>

@implementation Comment

@dynamic text;
@dynamic userID;
@dynamic photoID;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Comment";
}
@end
