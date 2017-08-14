//
//  ViewController.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import "ViewController.h"
#import "CXMLParser.h"
#import "testDelegate.h"
@interface ViewController ()<CXMLParserDelegate,testDelegateDelegate>{
    
    CXMLParser *parser;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    parser = [CXMLParser sharedManager];
    parser.delegate = self;
    
    testDelegate *test = [[testDelegate alloc] init];
    test.delegate = self;

}

-(void) isReady{
    
    NSLog(@"is ready");
}
-(void)parserDidFinishParsing:(CXMLParser *)parser withXMLData:(NSMutableDictionary *)data{
    
    NSLog(@"%@", data);
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
