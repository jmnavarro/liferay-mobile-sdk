//
//  testsTests.m
//  testsTests
//
//  Created by JM on 24/03/14.
//  Copyright (c) 2014 Liferay. All rights reserved.
//

#import "BaseTest.h"
#import "LRSession.h"


@implementation BaseTest

- (void)setUp
{
    [super setUp];
    
    [self loadSettings];
    
    _session = [[LRSession alloc] init:[NSString stringWithFormat:@"http://%@", self.settings[@"server"]]
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
