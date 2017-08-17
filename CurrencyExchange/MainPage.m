//
//  MainPage.m
//  CurrencyExchange
//
//  Created by Önder ÖZCAN on 16/08/2017.
//  Copyright © 2017 pixelblind. All rights reserved.
//

#import "MainPage.h"
#import "CurrencyCell.h"
#import "CXMLParser.h"
#import "currencyData.h"

@interface MainPage ()<UICollectionViewDelegate,UICollectionViewDataSource,CXMLParserDelegate>{
    
    CXMLParser *parser;
    currencyData *cData;
    float gbpRate;
    float usdRate;
    NSInteger currentIndex1;
    NSInteger currentIndex2;
    float balance1;
    float balance2;
    CurrencyCell *cell1;
    CurrencyCell *cell2;


}
@property NSArray *currencyArray;

@property NSArray *reverseCurrencyArray;
@end

@implementation MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.tag = 1;
    self.collection2.delegate = self;
    self.collection2.dataSource = self;
    self.collection2.tag = 2;
    self.currencyArray = @[@"EUR",@"GBP",@"USD"];
    self.reverseCurrencyArray = @[@"USD",@"GBP"];
    
    [[CXMLParser sharedManager] setDelegate:self];
    cData = [currencyData sharedManager];
    
    [currencyData setEur:100];
    [currencyData setGBP:100];
    [currencyData setUSD:100];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(parserHasFinishedParsing:)
//                                                 name:@"parserHasFinishedParsing"
//                                               object:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)parserHasFinishedParsing: (NSNotification *) notification{
//    NSDictionary *userInfo = notification.userInfo;
//    gbpRate = [[userInfo objectForKey:@"GBP"] floatValue];
//    usdRate = [[userInfo objectForKey:@"USD"] floatValue];
//    self.labelCurrency.text = [NSString stringWithFormat:@"1€ equals %.03f $ ",usdRate];
//}

-(void)adapterHasFinishedParsingWithDictionary:(NSDictionary *)data{
    
    gbpRate = [[data objectForKey:@"GBP"] floatValue];
    usdRate = [[data objectForKey:@"USD"] floatValue];
    self.labelCurrency.text = [NSString stringWithFormat:@"1€ equals %.03f $ ",usdRate];

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView.tag ==1){
        return self.currencyArray.count;

    } else {
        
        return self.reverseCurrencyArray.count;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    CurrencyCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"currencyCell" forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    
    switch (collectionView.tag) {
        case 1:
            cell.labelCurrency1.text = [self.currencyArray objectAtIndex:indexPath.row];
            cell.fieldInput1.tag = 1;

            [cell.fieldInput1 addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];


            switch (indexPath.row) {
                case 0:
                    //Euro
                    cell.labelBalance1.text = [NSString stringWithFormat:@"You have %.03f €",[currencyData getEur]];
                    cell.fieldInput1.text  = [NSString stringWithFormat:@"%.03f",[currencyData getEur]];
                    return cell;
                case 1:
                    //GBP
                    cell.labelBalance1.text = [NSString stringWithFormat:@"You have %.03f £",[currencyData getGBP]];
                    cell.fieldInput1.text  = [NSString stringWithFormat:@"%.03f",[currencyData getGBP]];
                    return cell;
                    
                case 2:
                    //USD
                    cell.labelBalance1.text = [NSString stringWithFormat:@"You have %.03f $",[currencyData getUSD]];
                    cell.fieldInput1.text  = [NSString stringWithFormat:@"%.03f",[currencyData getUSD]];

                    return cell;
                    
            }

            return cell;
            
        case 2:
            cell.labelCurrency2.text = [self.reverseCurrencyArray objectAtIndex:indexPath.row];
            cell.fieldInput1.tag = 2;
            
            [cell.fieldInput2 addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];

            switch (indexPath.row) {
                case 0:
                    //USD
                    cell.labelBalance2.text = [NSString stringWithFormat:@"You have %.03f $",[currencyData getUSD]];
                    cell.fieldInput2.text  = [NSString stringWithFormat:@"%.03f",[currencyData getUSD]];

                    return cell;
                case 1:
                    //GBP
                    cell.labelBalance2.text = [NSString stringWithFormat:@"You have %.03f £",[currencyData getGBP]];
                    cell.fieldInput2.text  = [NSString stringWithFormat:@"%.03f",[currencyData getGBP]];

                    return cell;
                    
                case 2:
                    //Euro
                    cell.labelBalance2.text = [NSString stringWithFormat:@"You have %.03f €",[currencyData getEur]];
                    cell.fieldInput2.text  = [NSString stringWithFormat:@"%.03f",[currencyData getEur]];

                    return cell;
                    
            }
            
            default:
            return cell;
            
    }
}

-(void)editingChanged:(UITextField *)sender{
    
    if(sender.tag == 1){
        float change1 = [sender.text floatValue];
        balance1 = change1;
    }
    
    if(sender.tag == 2){
        float change2 = [sender.text floatValue];
        balance2 = change2;
    }
}


-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([cell isKindOfClass:[CurrencyCell class]]){
        
        CurrencyCell *tmpCell = (CurrencyCell *)cell;
        
        if(collectionView.tag == 1){
            tmpCell.pageControl1.currentPage = indexPath.row;
            currentIndex1 = indexPath.row;
            balance1 = [tmpCell.fieldInput1.text floatValue];
            cell1 = tmpCell;
        }
        
        if(collectionView.tag == 2){
            tmpCell.pageControl2.currentPage = indexPath.row;
            currentIndex2 = indexPath.row;
            balance2 = [tmpCell.fieldInput2.text floatValue];
            
            if(indexPath.row ==0){
                self.labelCurrency.text = [NSString stringWithFormat:@"1€ equals %.03f $ ",usdRate];

            } else {
                self.labelCurrency.text = [NSString stringWithFormat:@"1€ equals %.03f £ ",gbpRate];

            }

            cell2 = tmpCell;
        }
    }

}


-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    

}
- (IBAction)exchange:(id)sender {
    
    
    NSString *currency1 = [self.currencyArray objectAtIndex:currentIndex1];
    NSString *currency2 = [self.reverseCurrencyArray objectAtIndex:currentIndex2];
    //Exhange the currencies
    //Calculate rates
    float newBalance = 0;
    
    if([currency2 isEqualToString:@"GBP"]){
        
        newBalance  = balance1 * gbpRate + [currencyData getGBP]; //Euro to GBP calculation.
    }
    
    if([currency2 isEqualToString:@"USD"]){
        
        newBalance  = (balance1 * usdRate) + [currencyData getUSD]; //Euro to USD calculation.
    }
    float remainBalance = [currencyData getBalanceWithName:currency1] - balance1;
    
    //Set Rates
    [currencyData setCurrency:currency1 andBalance:remainBalance andCurrency2:currency2 andBalance2:newBalance];
    
    //Set fields.
    cell1.fieldInput1.text = [NSString stringWithFormat:@"%f",remainBalance];
    cell2.fieldInput2.text = [NSString stringWithFormat:@"%f",newBalance];
    currency1 = [NSString stringWithFormat:@"%f",remainBalance];
    currency2 = [NSString stringWithFormat:@"%f",newBalance];

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width  = self.view.frame.size.width;
    return CGSizeMake(width, 150);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
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
