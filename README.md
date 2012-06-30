Hitmeister Search API for iOS/Mac OS X
=====================

This is an implementation of the Hitmeister Search API in Objective-C to use with your iOS/Mac App.
It let's you search for products in the Hitmeister Database by either ISBN/EAN or ASIN code.

Setup
=====================
1. Add all files to your Xcode project
2. Add the following Frameworks to your project
	- CFNetwork.framework
	- SystemConfiguration.framework
	- MobileCoreServices.framework
	- CoreGraphics.framework
	- zlib.dylib
	
Usage
=====================
Import `HitmeisterAPI.h` and subscribe to the HMProductFound notification that is sent by the API class when a search returned a product

```objective-
#import "HitmeisterAPI.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Add notification observer
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productFound:) name:@"HMProductFound" object:nil];
	
	// Lookup a product by its EAN code
	[HitmeisterAPI lookupPriceByEAN:@"9783551577771"];
	
	// Lookup a product by ISBN
	// [HitmeisterAPI lookupPriceByISBN:@"9783551577771"];
	
	// Lookup product by ASIN code
	// [HitmeisterAPI lookupPriceByASIN:@"9783551577771"];
}

- (void) productFound:(NSNotification*)notification {
	Product *product = [[notification userInfo] objectForKey:@"product"];
	
	// ... do something with the product data...
}

@end
```

What data will be returned
=====================
The Hitmeister API returns the following data for a product:
- Title/Name
- EAN Code
- URL to the product
- Affiliate/Partner-URL
- Cheapest price (new and used)
- Shipping costs (new and used)
- Savings compared to the listprice of the product
- Commission category