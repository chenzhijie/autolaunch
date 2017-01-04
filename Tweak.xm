
@interface SBApplication : NSObject
@end

%hook SBApplication

- (void)didExitWithType:(int)arg1 terminationReason:(int)arg2 {
	%orig;
	NSArray *shouldAutoLaunchAppBundleIdArray = @[@"com.tencent.xin"];
	NSString *currentAppBundleId = [self valueForKey:@"_bundleIdentifier"];
	NSInteger exitType = arg1;
	if(exitType == 5 && [shouldAutoLaunchAppBundleIdArray containsObject:currentAppBundleId]) {
		int createSubProcessResult = fork();
		if(createSubProcessResult == 0) {
			NSLog(@"auto launch");
			execl("/usr/bin/open","open",[currentAppBundleId UTF8String],NULL);
		}
	}
}

%end

