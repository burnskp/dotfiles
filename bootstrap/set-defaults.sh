#!/bin/bash
if [[ "$(defaults read com.apple.dock autohide)" -eq 0 ]]; then
  defaults write com.apple.dock orientation -string right
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.screencapture location -string ~/Pictures/screenshots
  defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
  defaults write com.apple.finder FXDefaultSearchScope -string SCcf
  defaults write com.apple.finder FXRemoveOldTrashItems -bool true
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
  defaults write com.apple.dock mru-spaces -bool false
  defaults write com.apple.dock expose-group-apps -bool true
  defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true
  defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
  defaults write NSGlobalDomain KB_DoubleQuoteOption -string \\abc\\
  defaults write NSGlobalDomain KB_SingleQuoteOption -string 'abc'
  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
  defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool true
  defaults write NSGlobalDomain com.apple.sound.beep.volume -bool false
  defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -bool false
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
  defaults write com.apple.WindowManager AppWindowGroupingBehavior -bool true
  defaults write com.apple.WindowManager AutoHide -bool false
  defaults write com.apple.WindowManager HideDesktop -bool true
  defaults write com.apple.WindowManager StageManagerHideWidgets -bool false
  defaults write com.apple.WindowManager StandardHideDesktopIcons -bool true
  defaults write com.apple.WindowManager StandardHideWidgets -bool false
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  defaults write com.apple.menuextra.clock ShowDate -int 2
  defaults write com.apple.menuextra.clock ShowDayOfWeek -bool false

  killall Dock
  killall Finder
fi
