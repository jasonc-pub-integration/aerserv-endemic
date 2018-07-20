
#import "NativeStatic.h"

@interface NativeStatic () <ASNativeAdViewElements>
    

    @property (nonatomic, assign) IBOutlet UIImageView* mainImgView;
    @property (nonatomic, assign) IBOutlet UIImageView* iconImgView;
    @property (nonatomic, assign) IBOutlet UILabel* sponsoredLbl;
    @property (nonatomic, assign) IBOutlet UIButton* ctaBtn;
    @property (weak, nonatomic) IBOutlet UILabel *descLbl;
    @property (weak, nonatomic) IBOutlet UILabel *titleLbl;


    @end

@implementation NativeStatic



- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        
        self.viewDelegate = self;
        NSLog( @"[DEBUG - NativeStatic] initWithCodeR aDecoder delegate  ");

    }
    return self;
}
    
#pragma mark - ASNativeAdViewElements Protocol Methods
    
- (UIImageView*)nativeMainImgViewFromAdView:(ASNativeAdView*)nativeView {
    NSLog( @"[DEBUG - NativeStatic] nativeMainImgViewFromAdView");
    return self.mainImgView;
}
    
- (UIImageView*)nativeIconImgViewFromAdView:(ASNativeAdView*)nativeView {
    NSLog( @"[DEBUG - NativeStatic] nativeIconImgViewFromAdView");
    return self.iconImgView;
}
    
- (UILabel*)nativeSponsoredLblFromAdView:(ASNativeAdView*)nativeView {
    NSLog( @"[DEBUG - NativeStatic] nativeSponsoredLblFromAdView");
    return self.sponsoredLbl;
}
    
- (UILabel*)nativePrimaryDescLblFromAdView:(ASNativeAdView*)nativeView {
    NSLog( @"[DEBUG - NativeStatic] nativePrimaryDescLblFromAdView");

    return self.descLbl;
}
    
- (UILabel*)nativeTitleLblFromAdView:(ASNativeAdView*)nativeView {
    NSLog( @"[DEBUG - NativeStatic] nativeTitleLblFromAdView");

    return self.titleLbl;
}
    
- (UIButton*)nativeActionBtnFromAdView:(ASNativeAdView*)nativeView {
    NSLog( @"[DEBUG - NativeStatic] nativeActionBtnFromAdView");
    return self.ctaBtn;
}
    
    @end
