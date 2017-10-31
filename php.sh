#!/usr/bin/env bash

# Install composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=$HOME/.bin --filename=composer
php -r "unlink('composer-setup.php');"

# Install global composer packages
composerPackages=(
  bamarni/symfony-console-autocomplete
  friendsofphp/php-cs-fixer
)

php $HOME/.bin/composer global require ${composerPackages[@]}

# Link MAMP PHP binaries to local path
rm ~/.bin/php*
for phpVersion in /Applications/MAMP/bin/php/php*
do
  ln -snvf $phpVersion/bin/php "$HOME/.bin/$(basename $phpVersion | sed -e 's/\(php[^.]*\)\.\([^.]*\)\(.*\)/\1\2/g')"
done
