//CREATED BY FREEAPPL3 @TER4M 2025
#import <SpringBoard/SpringBoard.h>
#import "KASHeaders.h"//This is just a header file I use for any private headers I might be using those can be viewed here https://developer.limneos.net/


//I use static sparingly for universal vars within tweak.xm
static  NSMutableArray* _allRecents;
static SBAppSwitcherModel *appSwitcherModel;
static SBSwitcherAppSuggestionViewController *appSugViewCntr;

// we start hooking the process of private header classes these can be simple %hook process or more in depth with %hoof %group ect docs can be found here  https://theos.dev/docs/logos-syntax


%hook SBAppSwitcherModel

-(id)initWithIconController:(id)arg1 applicationController:(id)arg2 recents:(id)arg3 {
    %orig;//ensure class is ran first
    //store the model in our own ivar
    appSwitcherModel = self;
    return %orig;//always return %orig unless you are overriding the orig function of method
}

-(id)_recentAppLayoutsController{
    
    %orig;
    //grab the layout of the model
    SBRecentAppLayouts *layout = %orig;
    _allRecents = MSHookIvar<NSMutableArray *>(layout, "_allRecents");
    
    return %orig;
}


%end


%hook SBDeckSwitcherViewController


%property (nonatomic, strong) UIButton *closeAllButton;

-(void)viewWillAppear:(BOOL)animated
{
    %orig;
    
    //uncomment below for logging. I use IOSComsole and run a search on a tag such as KAS
    //NSLog (@"KAS recents %@ Count %lu",_allRecents,[_allRecents count]);
    
    if([_allRecents count] > 1){   //only add button if there is more than 1 recent
       
        if(self.closeAllButton){ //btn is already created just hide/show
          
            self.closeAllButton.hidden = NO;
           
        }else{//button is not yet been created lets do that now
            self.closeAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.closeAllButton.backgroundColor = [UIColor darkGrayColor];
            self.closeAllButton.frame = CGRectMake(100,700,160,50);//this shouldnt be static 
            [self.closeAllButton setTitle:@"Close All" forState:UIControlStateNormal];
            self.closeAllButton.layer.cornerRadius = 25;
            self.closeAllButton.clipsToBounds = YES;
            [self.closeAllButton addTarget:self action:@selector(closeTabs) forControlEvents:UIControlEventTouchUpInside];
            
            //Utilize MSHookIvar do grab private header ivar
            SBSwitcherAppSuggestionViewController *appSugViewCntr = MSHookIvar<SBSwitcherAppSuggestionViewController *>(self, "_appSuggestionController");
            [appSugViewCntr.view addSubview:self.closeAllButton];
        }
    }

    return %orig;
}

//be sure to add %new to any new method your are adding to a class
%new
-(void) closeTabs {
    
    for(id recentApp in _allRecents){
        //if desired animate views before removal and close out switcher view here
        [appSwitcherModel remove:recentApp];
    }
    //remove button from view
    self.closeAllButton.hidden = YES;
    //blur view is still present at this time. Ultimatley you should closing the multitask view here progmatically
}

%end

//Overall we have added a great new feature to IOS that should be standard stock but is not for whatever reason. Simple features can be achived with very little code or disruptance to Springboard
