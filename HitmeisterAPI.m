//
//  HitmeisterAPI.m
//  Hitmeister API
//
//  Created by Björn Kaiser on 29.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HitmeisterAPI.h"

#define EAN_API_URL @"http://www.hitmeister.de/api/Items/GetPrice?ean=%@"
#define ISBN_API_URL @"http://www.hitmeister.de/api/Items/GetPrice?isbn=%@"
#define ASIN_API_URL @"http://www.hitmeister.de/api/Items/GetPrice?asin=%@"

@interface HitmeisterAPI ()
	+ (void) executeRequetsWithURL:(NSURL*)requestUrl;
@end

@implementation HitmeisterAPI

+ (void) executeRequetsWithURL:(NSURL*)requestUrl {
	ASIHTTPRequest *apiRequest = [[ASIHTTPRequest alloc] initWithURL:requestUrl];
	__block ASIHTTPRequest *weakRequest = apiRequest;
	[apiRequest setCompletionBlock:^{
		NSData *response = [weakRequest responseData];
		NSArray *productInfo = PerformXMLXPathQuery(response, @"/hitmeister/result/field");
		if([productInfo count] == 0) {
			[[NSNotificationCenter defaultCenter] postNotificationName:@"HMNoProductFound" object:nil userInfo:nil];
		} else {
			Product *product = [[Product alloc] init];
			for (NSDictionary *attribute in productInfo) {
				@try {
					NSString *key = [[[attribute objectForKey:@"nodeAttributeArray"] objectAtIndex:0] objectForKey:@"nodeContent"];
					NSString *value = [[[attribute objectForKey:@"nodeAttributeArray"] objectAtIndex:1] objectForKey:@"nodeContent"];
					[product setValue:value forKey:key];
				}
				@catch (NSException *exception) {
					NSLog(@"Catched exception %@", exception);
				}
			}
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"HMProductFound" object:nil userInfo:[NSDictionary dictionaryWithObject:product forKey:@"product"]];
		}
		weakRequest = nil;
	}];
	
	[apiRequest setFailedBlock:^{
		// Something bad happened...
		weakRequest = nil;
		
		// Post notification
		[[NSNotificationCenter defaultCenter] postNotificationName:@"HMRequestFailed" object:nil userInfo:[NSDictionary dictionaryWithObject:[weakRequest error] forKey:@"error"]];
	}];
	
	[apiRequest startAsynchronous];
}

+ (void) lookupPriceByEAN:(NSString*)eanCode {
	[HitmeisterAPI executeRequetsWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:EAN_API_URL, eanCode]]];
}

+ (void) lookupPriceByISBN:(NSString*)isbn {
	[HitmeisterAPI executeRequetsWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:ISBN_API_URL, isbn]]];
}

+ (void) lookupPriceByASIN:(NSString*)asin {
	[HitmeisterAPI executeRequetsWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:ASIN_API_URL, asin]]];
}

@end
