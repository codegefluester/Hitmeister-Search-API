//
//  Product.m
//  Hitmeister API
//
//  Created by Björn Kaiser on 29.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Product.h"

@interface Product()
	- (NSString*) formatPrice:(int)price;
@end

@implementation Product

@synthesize item_title;
@synthesize ean;
@synthesize url;
@synthesize url_hitmeisterpartner;
@synthesize url_hitmeisteraffiliate;
@synthesize cheapest_price;
@synthesize cheapest_new_price;
@synthesize cheapest_used_price;
@synthesize shipping_cost_new;
@synthesize shipping_cost_used;
@synthesize listprice_savings;
@synthesize commission_category;

- (NSString*) getCheapestPriceFormatted 
{
	return [self formatPrice:self.cheapest_price];
}

- (NSString*) getCheapestNewPriceFormatted 
{
	return [self formatPrice:self.cheapest_new_price];
}

- (NSString*) getCheapestUsedPriceFormatted 
{
	return [self formatPrice:self.cheapest_used_price];
}

- (NSString*) getShippingCostUsedFormatted 
{
	return [self formatPrice:self.shipping_cost_used];
}

- (NSString*) getShippingCostNewFormatted 
{
	return [self formatPrice:self.shipping_cost_new];
}

- (NSString*) formatPrice:(int)price 
{
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"]];
	return [formatter stringFromNumber:[NSNumber numberWithInt:(price/100)]];
}

@end
