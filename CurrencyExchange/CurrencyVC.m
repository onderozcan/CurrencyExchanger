//
//  CurrencyVC.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import "CurrencyVC.h"
#pragma mark XMLParser Adapter
#import "CXMLParser.h"
#define currencyURL @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"

@interface CurrencyVC ()<CXMLParserDelegate>

@property CXMLParser *parser;

@end

@implementation CurrencyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if([NSURL URLWithString:currencyURL]){
        self.parser = [[CXMLParser sharedManager] initWithURL:[NSURL URLWithString:currencyURL]];
        [self.parser setDelegate:self];
    }
    
}

-(void)adapterReady:(NSMutableDictionary *)currencyData{
#pragma mark CXMLParser has finished the parsing
    NSLog(@"Parser is ready, Here is the currencies%@",currencyData);
}

-(void)adapterParseError:(NSString *)error{
    
    NSLog(@"Adapter Error =%@",error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
