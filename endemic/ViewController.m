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

@interface ViewController () <ASAdViewDelegate, ASNativeAdDelegate>
    
    @property (nonatomic, strong) ASAdView* banner_view;
    @property (nonatomic, strong) NativeStatic* native_static;
    @property (nonatomic, strong) UIView* dummy_nib;

#define kPredefinedBannerAdSize 60.0f
#define kNativeStaticPLC @"380568"

@end

@implementation ViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
//     [self loadBannerAd];
      [self on_click_native_static];
    [self loadDummyNib];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    - (void)loadBannerAd {
        
        if (self.banner_view != nil) {
            [self.banner_view cancel];
            [self.banner_view removeFromSuperview];
            self.banner_view = nil;
        }
        
        // Create the AerServ banner object
        self.banner_view = [ASAdView viewWithPlacementID:@"380000" andAdSize:ASBannerSize];
        
        self.banner_view.delegate = self;
        self.banner_view.sizeAdToFit = YES;
        self.banner_view.locationServicesEnabled = YES;
        // Add banner to a parent view
        [self.view addSubview:self.banner_view];
        
        // Use loadAd to make a request to the AerServ ad server for a ad
        [self.banner_view loadAd];
    }



- (void)loadDummyNib {
    
    CGFloat viewWidth = 0.0f;
    CGFloat viewHeight = 0.0f;
    
    viewWidth = self.view.frame.size.width;
    viewHeight = self.view.frame.size.height;
    
    
    CGFloat xPos = (viewWidth - self.dummy_nib.frame.size.width)/2;
    CGFloat yPos = viewHeight - self.dummy_nib.frame.size.height;
    self.dummy_nib.frame = CGRectMake(xPos, yPos, self.dummy_nib.frame.size.width, self.dummy_nib.frame.size.height);
    
    
    self.dummy_nib =  [[[NSBundle mainBundle] loadNibNamed:@"ContentStatic" owner:self options:nil] firstObject];
    [self.view addSubview:self.dummy_nib];
    
}

    
    - (void)viewDidLayoutSubviews {
        [super viewDidLayoutSubviews];
        
        CGFloat viewWidth = 0.0f;
        CGFloat viewHeight = 0.0f;
        
        viewWidth = self.view.frame.size.width;
        viewHeight = self.view.frame.size.height;
        
        
        

        
        
        
        if(self.banner_view != nil) {
            
            NSLog(@"[DEBUG] viewDidLayoutSubviews - banner_view != nil");

            
            CGFloat viewWidth = 0.0f, viewHeight = 0.0f, xPosOffset = 0.0f, yPosOffset = 0.0f;
            if(kIS_iOS_11_OR_LATER) {
                xPosOffset = self.view.safeAreaLayoutGuide.layoutFrame.origin.x;
                yPosOffset = self.view.safeAreaLayoutGuide.layoutFrame.origin.y;
                viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.size.width;
                viewHeight = self.view.safeAreaLayoutGuide.layoutFrame.size.height;
            } else {
                viewWidth = self.view.frame.size.width;
                viewHeight = self.view.frame.size.height;
            }
            
            CGFloat bannerFrameWidth = self.banner_view.frame.size.width;
            CGFloat xPos = (bannerFrameWidth > viewWidth) ? xPosOffset : xPosOffset + ((viewWidth - bannerFrameWidth)/2);
            CGFloat yPos = yPosOffset + viewHeight - kPredefinedBannerAdSize;
            self.banner_view.frame = CGRectMake(xPos, yPos, bannerFrameWidth, kPredefinedBannerAdSize);
        }
        
        if(self.native_static) {
            
            NSLog(@"[DEBUG] viewDidLayoutSubviews - native_static");
            
            CGFloat xPos = (viewWidth - self.native_static.frame.size.width)/2;
            CGFloat yPos = viewHeight - self.native_static.frame.size.height;
            self.native_static.frame = CGRectMake(xPos, yPos, self.native_static.frame.size.width, self.native_static.frame.size.height);

        }
        
    }

    
#pragma mark - Banner Methods

- (UIViewController*)viewControllerForPresentingModalView {
    return self;
}
    
- (void)adViewDidFailToLoadAd:(ASAdView*)adView withError:(NSError*)error {
    NSLog(@"Banner ad did fail to load with error: %@", error.localizedDescription);
}
    
- (void)adViewDidLoadAd:(ASAdView*)adView {
    NSLog(@"Banner ad did load");
    [self viewDidLayoutSubviews];
}
    
- (void)adViewDidPreloadAd:(ASAdView*)adView {
    NSLog(@"Banner ad did preload");
}
    
- (void)adViewDidVirtualCurrencyLoad:(ASAdView*)adView vcData:(NSDictionary*)vcData {
    NSLog(@"Banner ad with virtual currency did load: %@", vcData);
}
    
- (void)adViewDidVirtualCurrencyReward:(ASAdView*)adView vcData:(NSDictionary*)vcData {
    NSLog(@"Banner ad with virtual currency did reward: %@", vcData);
}
    
- (void)adWasClicked:(ASAdView*)adView {
    NSLog(@"Banner ad was clicked");
}
    
- (void)adViewDidCompletePlayingWithVastAd:(ASAdView*)adView {
    NSLog(@"Banner ad did complete playing");
    [self.banner_view cancel];
    [self.banner_view removeFromSuperview];
    self.banner_view = nil;
}
    
#pragma mark - Native Methods

// Called to clear static
- (void)removeNativeStatic {
    NSLog(@"[DEBUG] removeNativeStatic - being removed from super view");
    [self.native_static removeFromSuperview];
    [self.native_static cancel];
    self.native_static = nil;
}

- (void)on_click_native_static {
    
    [self removeNativeStatic];
    NSLog(@"[DEBUG] on_click_native_static - calling removeNativeStatic");

    if(!self.native_static) {
        NSLog(@"[DEBUG] on_click_native_static - native_static create as it does not exist; loading ad");
        
        self.native_static = [[[NSBundle mainBundle] loadNibNamed:@"NativeStatic" owner:self.native_static options:nil] firstObject];
        [self.native_static configurePlacement:kNativeStaticPLC andDelegate:self];
        [self.native_static loadAd];

    } else {
        [self removeNativeStatic];
        NSLog(@"[DEBUG] on_click_native_static - removeNativeStatic, nothing was done.");
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
