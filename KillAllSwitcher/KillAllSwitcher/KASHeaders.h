//
//  FreeAppl3 @ter4m 
//
//  Created by MacBook Retina Pro on 2/19/25.
//

#import <UIKit/UIKit.h>

@interface SBFluidSwitcherViewController : UIViewController
@end
@interface SBSwitcherAppSuggestionViewController : UIViewController
-(void)_animateOutAndRemoveCurrentBottomBannerWithCompletion:(/*^block*/id)arg1 ;
@end


@interface SBDeckSwitcherViewController : SBFluidSwitcherViewController
@property (nonatomic, strong) UIButton *closeAllButton;
@property (nonatomic,retain) SBSwitcherAppSuggestionViewController * appSuggestionController;
@end

@interface SBRecentAppLayouts : NSObject {
    NSMutableArray* _allRecents;
}
@end

@interface SBAppSwitcherModel : NSObject {
    SBRecentAppLayouts* _recents;
}
-(void)remove:(id)arg1 ;
@end


