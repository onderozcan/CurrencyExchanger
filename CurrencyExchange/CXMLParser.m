//
//  CXMLParser.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//
#import "CXMLParser.h"
#define currencyURL @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"

static CXMLParser *adapter = nil;

static NSXMLParser *cParser;
static NSString *currentTag;
static NSMutableDictionary *currencyPool;
static BOOL firstInit;

@implementation CXMLParser


+(CXMLParser *)sharedManager
{
    if (adapter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            currencyPool = [[NSMutableDictionary alloc] init];
            adapter = [[CXMLParser alloc] init];
            
        });
    }
    
    return adapter;
}


-(id)init{

    
    if (self = [super init]) {
        
        if([NSURL URLWithString:currencyURL]){
            firstInit = YES;
            [self parseCurrency];
        }
    }

    return self;
}

-(void)parseCurrency{
    
    cParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:currencyURL]];
    cParser.delegate = self;
    [cParser parse];

}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
    //let the user know that parser has already started to parse XML.
    NSLog(@"Adapter has started to parse XML");
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    if ( [elementName isEqualToString:@"Cube"]){
        
        NSString *attrValue=[attributeDict valueForKey:@"currency"];
        
        if([attrValue isEqualToString:@"USD"] || [attrValue isEqualToString:@"EUR"] || [attrValue isEqualToString:@"GBP"]){
            NSString *currencyValue=[attributeDict valueForKey:@"rate"];
            NSLog(@"The currency is =%@ and the value is =%@",attrValue,currencyValue);
            NSNumber *currencyExchange = (NSNumber *)currencyValue;
            
            if(currencyExchange != nil){
                //save in to Dictionary
                [currencyPool setObject:currencyExchange forKey:attrValue];
            }
        }
        return;
    }
}


- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    //Document Ends...
    if([currencyPool isKindOfClass:[NSMutableDictionary class]] && currencyPool.count >0 ){
        
        
        float timeInterval = firstInit ? 1.0 : 30.0;
        [NSTimer scheduledTimerWithTimeInterval: timeInterval
                                         target: self
                                       selector:@selector(parseCurrency)
                                       userInfo: nil repeats:NO];
        
        firstInit = NO;
        
        [self.delegate adapterHasFinishedParsingWithDictionary:currencyPool];

        
    }
    
}

@end
