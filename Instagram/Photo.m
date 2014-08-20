//
//  Photo.m
//  Instagram
//
//  Created by Gustavo Parrado on 19/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Photo.h"
#import <Parse/PFObject+Subclass.h>

@implementation Photo

@dynamic image;
@dynamic likes;
@dynamic location;
@dynamic owner;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Photo";
}

@end
