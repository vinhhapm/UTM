//
// Copyright © 2020 osy. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "UTMConfiguration+Constants.h"
#import "UTMConfiguration+Miscellaneous.h"

extern const NSString *const kUTMConfigInputKey;
extern const NSString *const kUTMConfigSoundKey;
extern const NSString *const kUTMConfigDebugKey;

const NSString *const kUTMConfigTouchscreenModeKey = @"TouchscreenMode";
const NSString *const kUTMConfigDirectInputKey = @"DirectInput";
const NSString *const kUTMConfigInputLegacyKey = @"InputLegacy";
const NSString *const kUTMConfigInputInvertScrollKey = @"InputInvertScroll";

const NSString *const kUTMConfigSoundEnabledKey = @"SoundEnabled";
const NSString *const kUTMConfigSoundCardDeviceKey = @"SoundCard";

const NSString *const kUTMConfigDebugLogKey = @"DebugLog";

@interface UTMConfiguration ()

@property (nonatomic, readonly) NSMutableDictionary *rootDict;

@end

@implementation UTMConfiguration (Miscellaneous)

#pragma mark - Migration

- (void)migrateMiscellaneousConfigurationIfNecessary {
    // Add Debug dict if not exists
    if (!self.rootDict[kUTMConfigDebugKey]) {
        self.rootDict[kUTMConfigDebugKey] = [NSMutableDictionary dictionary];
    }
    
    if (!self.rootDict[kUTMConfigSoundKey][kUTMConfigSoundCardDeviceKey]) {
        self.rootDict[kUTMConfigSoundKey][kUTMConfigSoundCardDeviceKey] = [UTMConfiguration supportedSoundCardDevices][0];
    }
    // Migrate input settings
    [self.rootDict[kUTMConfigInputKey] removeObjectForKey:kUTMConfigTouchscreenModeKey];
    [self.rootDict[kUTMConfigInputKey] removeObjectForKey:kUTMConfigDirectInputKey];
    if (!self.rootDict[kUTMConfigInputKey][kUTMConfigInputLegacyKey]) {
        self.inputLegacy = NO;
    }
}

#pragma mark - Other properties

- (void)setInputLegacy:(BOOL)inputDirect {
    self.rootDict[kUTMConfigInputKey][kUTMConfigInputLegacyKey] = @(inputDirect);
}

- (BOOL)inputLegacy {
    return [self.rootDict[kUTMConfigInputKey][kUTMConfigInputLegacyKey] boolValue];
}

- (void)setInputScrollInvert:(BOOL)inputScrollInvert {
    self.rootDict[kUTMConfigInputKey][kUTMConfigInputInvertScrollKey] = @(inputScrollInvert);
}

- (BOOL)inputScrollInvert {
    return [self.rootDict[kUTMConfigInputKey][kUTMConfigInputInvertScrollKey] boolValue];
}

- (void)setSoundEnabled:(BOOL)soundEnabled {
    self.rootDict[kUTMConfigSoundKey][kUTMConfigSoundEnabledKey] = @(soundEnabled);
}

- (BOOL)soundEnabled {
    return [self.rootDict[kUTMConfigSoundKey][kUTMConfigSoundEnabledKey] boolValue];
}

- (void)setSoundCard:(NSString *)soundCard {
    self.rootDict[kUTMConfigSoundKey][kUTMConfigSoundCardDeviceKey] = soundCard;
}

- (NSString *)soundCard {
    return self.rootDict[kUTMConfigSoundKey][kUTMConfigSoundCardDeviceKey];
}

- (BOOL)debugLogEnabled {
    return [self.rootDict[kUTMConfigDebugKey][kUTMConfigDebugLogKey] boolValue];
}

- (void)setDebugLogEnabled:(BOOL)debugLogEnabled {
    self.rootDict[kUTMConfigDebugKey][kUTMConfigDebugLogKey] = @(debugLogEnabled);
}

@end
