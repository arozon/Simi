#import "iosviewcontroller.h"
#import "backend.h"
@implementation QIOSViewController (MyView)

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (isLight) {

        return UIStatusBarStyleLightContent;
    }
    else {
        return UIStatusBarStyleDefault;
    }
}

@end

