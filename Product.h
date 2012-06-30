//
//  Product.h
//  Hitmeister API
//
//  Created by Björn Kaiser on 29.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject {
	NSString *item_title;
	NSString *ean;
	NSString *url;
	NSString *url_hitmeisteraffiliate;
	NSString *url_hitmeisterpartner;
	
	int cheapest_price;
	int cheapest_used_price;
	int cheapes_new_price;
	int shipping_cost_new;
	int shipping_cost_used;
	int listprice_savings;
	
	NSString *commission_category;
}

@property (nonatomic, strong) NSString *item_title;
@property (nonatomic, strong) NSString *ean;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *url_hitmeisteraffiliate;
@property (nonatomic, strong) NSString *url_hitmeisterpartner;

@property (nonatomic) int cheapest_price;
@property (nonatomic) int cheapest_used_price;
@property (nonatomic) int cheapest_new_price;
@property (nonatomic) int shipping_cost_new;
@property (nonatomic) int shipping_cost_used;
@property (nonatomic) int listprice_savings;

@property (nonatomic, strong) NSString *commission_category;

@end
