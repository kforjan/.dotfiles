#!/bin/sh
set -eu

defaults write -g EnableTilingByEdgeDrag -bool false
defaults write -g EnableTopTilingByEdgeDrag -bool false
defaults write -g EnableTilingOptionAccelerator -bool false
defaults write -g EnableTiledWindowMargins -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001

killall Finder Dock 2>/dev/null || true
echo "Log out and back in for the tiling and key-repeat changes to apply."
