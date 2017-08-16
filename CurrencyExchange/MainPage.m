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

@interface MainPage ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    CXMLParser *parser;
    currencyData *cData;
    float gbpRate;
    float usdRate;


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
    
    parser = [CXMLParser sharedManager];
    cData = [currencyData sharedManager];
    
    [currencyData setEur:100];
    [currencyData setGBP:100];
    [currencyData setUSD:100];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(parserHasFinishedParsing:)
                                                 name:@"parserHasFinishedParsing"
                                               object:nil];
    
    self.reverseCurrencyArray = [[self.currencyArray reverseObjectEnumerator] allObjects];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)parserHasFinishedParsing: (NSNotification *) notification{
    NSDictionary *userInfo = notification.userInfo;
    gbpRate = [[userInfo objectForKey:@"GBP"] floatValue];
    usdRate = [[userInfo objectForKey:@"USD"] floatValue];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.currencyArray.count;
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

            switch (indexPath.row) {
                case 0:
                    //Euro
                    cell.labelBalance1.text = [NSString stringWithFormat:@"You have %2f €",[currencyData getEur]];
                    
                case 1:
                    //GBP
                    cell.labelBalance1.text = [NSString stringWithFormat:@"You have %2f £",[currencyData getGBP]];
                    
                case 2:
                    //USD
                    cell.labelBalance1.text = [NSString stringWithFormat:@"You have %2f $",[currencyData getUSD]];
                    
            }

            
            return cell;
        case 2:
            cell.labelCurrency2.text = [self.reverseCurrencyArray objectAtIndex:indexPath.row];
            [self setCurrency:indexPath.row isFirstCurrency:NO andCell:cell];
            return cell;
        default:
            return cell;
    }
}


-(void)setCurrency:(NSInteger)index isFirstCurrency:(BOOL)isFirst andCell:(CurrencyCell *)cell{
    
    //Setting Labels.
    //first currency collection
    
    if(isFirst){
        switch (cell.tag) {
            case 0:
                //Euro
                cell.labelBalance1.text = [NSString stringWithFormat:@"You have %2f €",[currencyData getEur]];
                break;

            case 1:
                //GBP
                cell.labelBalance1.text = [NSString stringWithFormat:@"You have %2f £",[currencyData getGBP]];

            case 2:
                //USD
                cell.labelBalance1.text = [NSString stringWithFormat:@"You have %2f $",[currencyData getUSD]];
                
            default:
                break;
        }
    } else {
        //second currency colleciton
        switch (cell.tag) {
            case 0:
                //USD
                cell.labelBalance2.text = [NSString stringWithFormat:@"You have %f $",[currencyData getUSD]];
                

                break;
            case 1:
                //GBP
                cell.labelBalance2.text = [NSString stringWithFormat:@"You have %f £",[currencyData getGBP]];

            case 2:
                //EUR
                cell.labelBalance2.text = [NSString stringWithFormat:@"You have %f €",[currencyData getEur]];

                
            default:
                break;
        }
        
    }
}


-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    

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
