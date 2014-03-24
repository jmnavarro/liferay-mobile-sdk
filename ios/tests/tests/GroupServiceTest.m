//
//  testsTests.m
//  testsTests
//
//  Created by jmWork on 24/03/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

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
