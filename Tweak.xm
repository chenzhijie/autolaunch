
@interface SBApplication : NSObject
@end

%hook SBApplication

- (void)didExitWithType:(int)arg1 terminationReason:(int)arg2 {
	%orig;
	NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.ziacke.autolaunch.plist"] ;
	if(plist.allKeys.count == 0 || arg1 != 5) {
		return;
	}

	NSString *currentAppBundleId = [self valueForKey:@"_bundleIdentifier"];
	__block BOOL shouldAutoLaunch = NO;
    [plist enumerateKeysAndObjectsUsingBlock:^(NSString *bundlerIdentifier,NSNumber *isOpen, BOOL * _Nonnull stop) {
        if(([bundlerIdentifier rangeOfString:currentAppBundleId].location != NSNotFound) && isOpen.boolValue) {
            shouldAutoLaunch = YES;
            *stop = YES;
        }
    }];

    NSLog(@"shouldAutoLaunch :%i",shouldAutoLaunch);
	if(shouldAutoLaunch) {
		int createSubProcessResult = fork();
		if(createSubProcessResult == 0) {
			execl("/usr/bin/open","open",[currentAppBundleId UTF8String],NULL);
		}
	}
}

%end

