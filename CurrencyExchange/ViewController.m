//
//  ViewController.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 14/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import "ViewController.h"
#import "CXMLParser.h"
#import "currencyData.h"

typedef enum {
    start,
    usd,
    eur,
    gbp
} Currenies;

@import QuartzCore;

@interface ViewController ()<UITextFieldDelegate>{
    
    CXMLParser *parser;
    currencyData *cData;
    float gbpRate;
    float usdRate;
    NSString *currentCurrency;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(parserHasFinishedParsing:)
                                                 name:@"parserHasFinishedParsing"
                                               object:nil];
    
    
    [currencyData sharedManager];
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    currentCurrency = @"GBP";
    parser = [CXMLParser sharedManager];
    //Setting all currency data as equal to 100
    [currencyData setEur:100];
    [currencyData setGBP:100];
    [currencyData setUSD:100];
    [self designButtons];
    [self setButtonCurrency:0];
    [self setCurrencyFieldsWithAmount];
    
    
    
}

-(void)designButtons{
    
    self.buttonExchange.layer.cornerRadius = 5.0;
    self.buttonExchange.layer.masksToBounds = YES;
    
}

-(void)setCurrencyFieldsWithAmount{
    
    self.fieldCurrency1.text = [NSString stringWithFormat:@"%f",[currencyData getEur]];
    self.fieldCurrency2.text = [NSString stringWithFormat:@"%f",[currencyData getUSD]];
    [self.fieldCurrency1 becomeFirstResponder];

}

-(void)setButtonCurrency:(Currenies)type{
    
    
    switch (type) {
        case start:
            //Starting
            [self.buttonCurrency1 setTitle:@"EUR" forState:UIControlStateNormal];
            [self.buttonCurrency2 setTitle:@"GBP" forState:UIControlStateNormal];
            break;
        case usd:
            //Set the dollar
            [self.buttonCurrency2 setTitle:@"USD" forState:UIControlStateNormal];
            currentCurrency = @"USD";

            
            break;
            
        case gbp:
            //set the pound
            [self.buttonCurrency2 setTitle:@"GBP" forState:UIControlStateNormal];
            currentCurrency = @"GBP";

            break;
            
        default:
            break;
    }

    
}


- (IBAction)exchange:(id)sender {
    
    
}

-(void)calculateRate{
    
    if([currentCurrency isEqualToString:@"USD"]){
        
        //Euro to USD
        self.fieldCurrency2.text = [NSString stringWithFormat:@"%f",[currencyData getEur] * usdRate];
    }
    
    if([currentCurrency isEqualToString:@"GBP"]){
        
        //Euro to USD
        self.fieldCurrency2.text = [NSString stringWithFormat:@"%f",[currencyData getEur] * gbpRate];
    }

    
}

- (IBAction)setCurrency:(id)sender {
    
    [self.fieldCurrency1 resignFirstResponder];
    [self setAlertController];
}

-(void)parserHasFinishedParsing: (NSNotification *) notification{
    NSDictionary *userInfo = notification.userInfo;
    gbpRate = [[userInfo objectForKey:@"GBP"] floatValue];
    usdRate = [[userInfo objectForKey:@"USD"] floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAlertController{
    
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Currencies"
                                                                   message:@"Select a currency."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *button1 = [UIAlertAction actionWithTitle:@"GBP" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action) {
                                                        
                                                        [self setButtonCurrency:2];
                                                    }];
    
    UIAlertAction *button2 = [UIAlertAction actionWithTitle:@"USD" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                        [self setButtonCurrency:1];
                                                        
                                                    }];
    
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag ==1){
        //exchange rate 1
        
    }
    
    if(textField.tag ==2){
        //exchange rate 2
        
    }
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
