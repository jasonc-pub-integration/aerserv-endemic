//
//  ViewController.m
//  endemic
//
//  Created by Jason C on 7/20/18.
//  Copyright © 2018 Jason C. All rights reserved.
//

#import <AerServSDK/AerServSDK.h>
#import "ViewController.h"
#import "NativeStatic.h"

@interface ViewController () <ASNativeAdDelegate>
    
    @property (nonatomic, strong) ASAdView* banner_view;
    @property (nonatomic, strong) NativeStatic* native_static;
    @property (nonatomic, strong) UIView* dummy_nib;
    @property (nonatomic, strong) UIView* dummy_nib2;
    @property (nonatomic, strong) UIView* dummy_nib3;
    @property (nonatomic, strong) NSMutableArray *list;





#define kPredefinedBannerAdSize 60.0f
#define kNativeStaticPLC @"380568"

@end

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = [[NSMutableArray alloc] init];

    [self populateListView];
    [self renderListView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This is a manual function for testing this out
-(void)populateListView {
    
    self.dummy_nib =  [[[NSBundle mainBundle] loadNibNamed:@"ContentStatic" owner:self options:nil] firstObject];
    self.dummy_nib2 =  [[[NSBundle mainBundle] loadNibNamed:@"ContentStatic" owner:self options:nil] firstObject];
    self.dummy_nib3 =  [[[NSBundle mainBundle] loadNibNamed:@"ContentStatic" owner:self options:nil] firstObject];

    
    [self.list addObject:self.dummy_nib];
    [self.list addObject:self.dummy_nib2];
    
    [self loadNativeStatic];
    [self.list addObject:self.native_static];
    
    [self.list addObject:self.dummy_nib3];

}


-(void)renderListView {
    
    CGFloat viewWidth = 0.0f;
    CGFloat viewHeight = 0.0f;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    NSLog(@"[DEBUG] renderListView - rendering: %lu", (unsigned long)[self.list count]);
    
    for (int i = 0; i < [self.list count]; ++i ){
        NSLog(@"[DEBUG] renderListView - rendering an element");
        UIView* temp = [self.list objectAtIndex:i];
        temp.frame = CGRectMake(0, 200*i, temp.frame.size.width, temp.frame.size.height);
        [self.view addSubview:temp];
    }
    
    NSLog(@"[DEBUG] renderListView - done rendering");

    
}

#pragma mark - Native Methods

- (void)removeNativeStatic {
    [self.native_static removeFromSuperview];
    [self.native_static cancel];
    self.native_static = nil;
}

- (void)loadNativeStatic {
    [self removeNativeStatic];

    if(!self.native_static) {
        self.native_static = [[[NSBundle mainBundle] loadNibNamed:@"NativeStatic" owner:self.native_static options:nil] firstObject];
        [self.native_static configurePlacement:kNativeStaticPLC andDelegate:self];
        [self.native_static loadAd];

    } else {
        [self removeNativeStatic];
    }
}
    
    
#pragma mark - ASNativeAdDelegate
    
- (void)nativeAdDidLoad:(ASNativeAdView*)nativeAdView {
    NSLog(@"[DEBUG] ASNativeAdDelegate - Native ad did load");
    [self.view addSubview:nativeAdView];
}
    
- (void)nativeAd:(ASNativeAdView*)nativeAdView didFailToLoadWithError:(NSError*)error {
    NSLog(@"[DEBUG] ASNativeAdDelegate - Native ad failed to load with error: %@", error.localizedDescription);
}
    
- (UIViewController*)viewControllerForPresentingNativeAdView:(ASNativeAdView*)nativeAdView {
    NSLog(@"[DEBUG] viewControllerForPresentingNativeAdView - Native ad");
    return self;
}
    
- (void)nativeAdVideoDidStart:(ASNativeAdView*)nativeAdView {
    NSLog(@"Native video did start");
}
    
- (void)nativeAdVideoDidComplete:(ASNativeAdView*)nativeAdView {
    NSLog(@"Native video did complete");
}
    
- (void)nativeAdDidExpandToInterstitial:(ASNativeAdView*)nativeAdView {
    NSLog(@"Native ad did expand to interstitial");
}
    
- (void)nativeAdDidDismissInterstitial:(ASNativeAdView*)nativeAdView {
    NSLog(@"Native ad did dismiss interstitial");
}

    

@end
