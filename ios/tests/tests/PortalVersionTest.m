//
//  testsTests.m
//  testsTests
//
//  Created by jmWork on 24/03/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

#import "BaseTest.h"
#import "LRHttpUtil.h"

@interface PortalVersionTest : BaseTest

@end


@implementation PortalVersionTest

- (void)testGetPortalVersion
{
    NSError *error = nil;
    int version = [LRHttpUtil getPortalVersion:self.session error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqual(6200, version);
}

@end
