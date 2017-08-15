//
//  CXMLParser.h
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXMLParser : NSObject<NSXMLParserDelegate>
+(CXMLParser *)sharedManager;

@end
