
#import <SpringBoard/SpringBoard.h>
#import "KASHeaders.h"


static  NSMutableArray* _allRecents;
static SBRecentAppLayouts *appSwitcherLayout;


%hook SBSwitcherAppSuggestionContentView

-(id)initWithFrame:(CGRect) frame{
    %orig;
    UIButton *closeAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    closeAllButton.frame = CGRectMake(self.frame.size.width - 100,
                                      self.center.y,
                                      220,
                                      80);
                                      
       [closeAllButton setTitle:@"Close All" forState:UIControlStateNormal];
       [closeAllButton addTarget:self action:@selector(closeTabs) forControlEvents:UIControlEventTouchUpInside];
       
       [self addSubview:closeAllButton];


    return %orig;
}

%new
-(void) closeTabs {
    for(id recentApp in _allRecents){
        [appSwitcherLayout remove:recentApp];
    }
}

%end

%hook SBRecentAppLayouts

-(id)init{
    %orig;
   _allRecents = MSHookIvar<NSMutableArray *>(self, "_allRecents");
    appSwitcherLayout = self;
    return %orig;
}

%end


