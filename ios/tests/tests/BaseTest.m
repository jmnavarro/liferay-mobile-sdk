/**
 * Copyright (c) 2000-2013 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

#import "BaseTest.h"
#import "LRSession.h"


@implementation BaseTest

- (void)setUp
{
    [super setUp];
    
    [self loadSettings];
    
    NSString *url = [NSString stringWithFormat:@"http://%@", self.settings[@"server"]];
    
    self.session = [[LRSession alloc] init:url
                                  username:self.settings[@"login"]
                                  password:self.settings[@"password"]];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)loadSettings
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestSettings" ofType:@"plist"];
    self.settings = [[NSDictionary alloc] initWithContentsOfFile:path];
}


@end
