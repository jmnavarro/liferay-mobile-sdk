//
//  NSBundle+Localization.m
//  Liferay iOS SDK
//
//  Created by jmWork on 22/07/14.
//  Copyright (c) 2014 Liferay Inc. All rights reserved.
//

#import "NSBundle+Localization.h"

@implementation NSBundle (Localization)

+ (NSBundle *)localizedBundle {
	NSBundle *bundle = [self _sharedBundle];

	NSArray *preferredLanguages = [NSLocale preferredLanguages];

	NSLocale *currentLocale = [NSLocale localeWithLocaleIdentifier:
		[preferredLanguages objectAtIndex:0]];

    NSString *lang = [currentLocale.localeIdentifier substringToIndex:2];

    NSString *langPath = [bundle pathForResource:lang ofType:@"lproj"];

	for (int i = 0; !langPath && i < [preferredLanguages count]; ++i) {
		NSString *preferredLanguage = [preferredLanguages objectAtIndex:i];

		langPath = [bundle pathForResource:preferredLanguage ofType:@"lproj"];
	}

	return langPath ? [NSBundle bundleWithPath:langPath] : nil;
}

+ (NSBundle *)_sharedBundle {
    static NSBundle *classBundle  = nil;
    static NSBundle *sdkBundle = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        classBundle = [NSBundle bundleForClass:[self class]];

	    NSString *bundlePath =
			[classBundle pathForResource:@"Liferay-iOS-SDK" ofType:@"bundle"];

        sdkBundle = [NSBundle bundleWithPath:bundlePath];
    });

	return sdkBundle ?: classBundle;
}

- (NSString *)localizedStringForKey:(NSString *)key {
	return [self localizedStringForKey:key value:key table:@"UserMessages"];
}


@end
