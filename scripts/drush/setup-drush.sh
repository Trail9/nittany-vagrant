#!/usr/bin/sh
# setup drush via composer
cd ~
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' .bashrc
source .bashrc
# full path to execute in case root needs to log out before it picks it up
php /usr/local/bin/composer global require drush/drush:6.*
# copy in the elmsln server stuff as the baseline for .drush
if [ ! -d $HOME/.drush ]; then
  mkdir $HOME/.drush
fi
yes | cp -rf /var/www/elmsln/scripts/drush/server/* $HOME/.drush/
# stupid ubuntu drush thing to work with sudo
if [[ $os == '2' ]]; then
  ln -s /root/.composer/vendor/drush/drush /usr/share/drush
fi
drush cc drush
