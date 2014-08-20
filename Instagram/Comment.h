//
//  Comment.h
//  Instagram
//
//  Created by Gustavo Parrado on 20/8/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

@interface Comment : PFObject<PFSubclassing>
+ (NSString *)parseClassName;

@property (retain) NSString *text;
@property int userID;
@property int photoID;

@end
