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
Add the following line to your `viewDidLoad:` method to subscribe to the HMProductFound
notification that is sent by the API class when a search returned a product

```objective-
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// Add notification observer
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productFound:) name:@"HMProductFound" object:nil];
	
	// Lookup a product by its EAN code
	[HitmeisterAPI lookupPriceByEAN:@"9783551577771"];
}
```