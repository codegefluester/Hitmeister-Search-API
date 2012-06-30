//
//  HitmeisterAPI.h
//  Hitmeister API
//
//  Created by Björn Kaiser on 29.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "ASIHTTPRequest.h"
#import "XPathQuery.h"

@interface HitmeisterAPI : NSObject {

}

+ (void) lookupPriceByEAN:(NSString*)eanCode;
+ (void) lookupPriceByISBN:(NSString*)isbn;
+ (void) lookupPriceByASIN:(NSString*)asin;

@end
