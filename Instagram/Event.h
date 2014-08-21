//
//  Comment.h
//  Instagram
//
//  Created by Gustavo Parrado on 20/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "Photo.h"

@interface Event : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (retain) NSString *type;
@property (retain) PFUser *origin;
@property (retain) PFUser *destination;
@property (retain) NSString *details;
@property (retain) Photo *photo;

@end
