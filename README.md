# PHP-Web Container
This container provides a development environment for the PHP.net website.

## Stack
Operating system: **Ubuntu 18.04.3 LTS (Bionic Beaver)**

Web Server: **Apache 2.x**

PHP: **7.4**

## Usage
*Prerequisite*: Install the [docker](https://www.docker.com/) CLI tools for your environment.

1. Check out this repository, or download the files manually.

2. Run `docker-compose up` to run the image as a container. This will pipe local port `80` to the Apache instance running in the container. If you wish to forward to a different port, you can edit the `ports` configuration variable in `docker-compose.yml`. **Note**: The first time you run this command, it will download the server image from the Dockerfile and install the appropriate packages, this may take significant time on slower systems or those with limited bandwidth.

3. Check out [web-php](https://github.com/php/web-php) into the `/phpweb` directory with `git clone https://github.com/php/web-php.git phpweb`. Alternately, if you are unable to use git or github but have `rsync` available, you may use the provided `sync.sh` script to retrieve the php.net source. By default, this script skips all distribution files and syncs only the *english* manual files. **Important Note**: The [mirroring guidelines](https://www.php.net/mirroring.php) warn not to sync more than once every 6 hours, failure to adhere to this guideline may result in your IP address being banned from syncing in the future.

4. Visit `http://localhost:[your port here if not 80]` to view a working copy of the PHP.net website.

You can now edit the files contained in `/phpweb` and view live updates on your local copy!
