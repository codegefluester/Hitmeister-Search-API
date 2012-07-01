Hitmeister Search API for iOS/Mac OS X
=====================

This is an implementation of the [Hitmeister Search API](http://www.hitmeister.de/affiliate/schnittstelle/) in Objective-C to use with your iOS/Mac App.
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
	- libxml2.dylib
	
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
	// Product found
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productFound:) name:@"HMProductFound" object:nil];
	
	// No product found
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noProductFound:) name:@"HMNoProductFound" object:nil];
	
	// Search request failed 
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchFailed:) name:@"HMRequestFailed" object:nil];
	
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
	NSLog(@"Product name: %@", [product item_title]);
	NSLog(@"Cheapest price: %@", [product getCheapestPriceFormatted]);
}

- (void) noProductFound:(NSNotification*)notification {
	NSLog(@"No product found");
}

- (void) searchFailed:(NSNotification*)notification {
	NSLog(@"The search failed. The error was: %@", [[[notification userInfo] objectForKey:@"error"] description]);
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

Licence
=====================
You can use this code as you like in commercial and non-commercial projects. You are allowed to modify the code to fit
your needs as well. If you like you can also give me credit, but you don't have to :-)

I found a bug!
=====================
Tell me about the issue [here](https://github.com/codegefluester/Hitmeister-Search-API/issues).

Thanks to...
=====================
- The creators of ASIHTTPRequest for offering such an easy to use class!
- Matt Gallagher for the nice XPathQuery class! (http://cocoawithlove.com/2008/10/using-libxml2-for-parsing-and-xpath.html)