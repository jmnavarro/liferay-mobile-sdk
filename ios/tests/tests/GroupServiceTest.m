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
#import "LRGroupService_v62.h"

@interface GroupServiceTest : BaseTest

@end


@implementation GroupServiceTest

- (void)testGetUserSites
{
    LRGroupService_v62 *service = [[LRGroupService_v62 alloc] init:self.session];
    
    NSError *error = nil;
    NSArray* groups = [service getUserSites:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(2, [groups count]);
    
    NSDictionary *group = groups[0];
    XCTAssertEqualObjects(@"/test", group[@"friendlyURL"]);

    group = groups[1];
    XCTAssertEqualObjects(@"/guest", group[@"friendlyURL"]);
}

@end
