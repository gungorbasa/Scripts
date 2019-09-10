# Ask for the administrator password upfront.
echo "Setting ZSH as shell..."
chsh -s /bin/zsh
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
#
# echo "Installing xcode Developer Tools"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update
echo "Installing Git..."
brew install git

echo "Installing brew git utilities..."
brew install git-extras
brew install legit
brew install git-flow

echo "Installing other brew stuff..."
brew install tree
brew install wget
brew install mackup
brew install node
brew install unrar


# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# Install more recent versions of some OS X tools.
brew install vim

echo "Cleaning up brew"
brew cleanup

Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh
echo "Setting up Oh My Zsh theme..."
cd  ~/.oh-my-zsh/themes
curl https://gist.githubusercontent.com/bradp/a52fffd9cad1cd51edb7/raw/cb46de8e4c77beb7fad38c81dbddf531d9875c78/brad-muse.zsh-theme > brad-muse.zsh-theme
echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

# Apps
cask=(
  alfred
  p4v
  google-chrome
  sourcetree
  spotify
  iterm2
  sublime-text
  atom
  vlc
  skype
  java
  intellij-idea-ce
  android-studio
  slack
)
# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${cask[@]}
brew cask alfred link
brew cask cleanup

echo "Installing android-sdk"
brew install android-sdk
brew cleanup

#"Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

#"Setting screenshots location to ~/Documents/Screenshots"
mkdir -p "$HOME/Documents/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Documents/Screenshots"
#"Setting screenshot format to PNG"
defaults write com.apple.screencapture type -string "png"
#"Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
#"Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Creates Some aliases
echo 'alias ohmyzsh="atom ~/.oh-my-zsh"' >> ~/.zshrc
echo 'alias zshconfig="atom ~/.zshrc"' >> ~/.zshrc

######################### New commands for convenience #########################
echo 'alias cartupdate="carthage bootstrap --platform ios --cache-builds --no-use-binaries --new-resolver"' >> ~/.zshrc
echo 'alias zshconfig="atom ~/.zshrc"export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
################################################################################


killall Finder
echo "Done!"
