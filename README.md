Odoo development deployment
===========================

This Repo contains a helperscript `deploy` to setup a new local odoo instance easily. This is only testet on windows with _wsl_ but should work on plain linux too. Of course requirements differ then.

Requirements
------------

There are some submodules (other addons) that you may not have access to. You can easily adapt the templates in the templates folder to your needs.

On windows we need

* Windwows Subsystem for Linux (aka. wsl2)
* Ubuntu
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* installed root certifivate from mkcert (see below)

WSL and Ubuntu can be installed from _Microsoft Store_, Docker Desktop can be downloaded from [here](https://www.docker.com/products/docker-desktop/). If you star Docker Desktop for the first time make sure to share _Settings -> Resources -> WSL integration_ with Ubuntu.

In Ubuntu we need

* mkcert
* docker.io
* docker-compose

All packages can be installed from package management
```
sudo apt install mkcert docker.io docker-compose
```

After installing mkcert, we need to generate a root-certificate for our upcomming docker deployments. This can be done by `mkcert -install`. Afterwards the root-certificate must be importet to your windows or firefox.
Run `mkcert -CAROOT` to find the folder where the certificates are.

Now on Windows search for "User certificates" (german Benutzerzertifikate), and right-click on _Certificate Authority -> Tasks -> Import (german Vertrauenswürdige Stammzertifikate -> Alle Aufgeben -> Importieren)_.

For Firefox you can find the import option in _Settings -> Privacy -> Certificates_.

Go back to your Ubuntu and clone this repo into a separate folder.
```
git clone git@github.com:ng-ife/odoo-deployment.git 
```
For nginx to work, we first create a shared network.
```
docker network create nginx-net
```

Now everything should be ready to deploy.

How to deploy a new odoo instance
---------------------------------

Simply go to your deployment folder (in my case docker) and create an new instance.
```
➜  cd docker
➜  ./deploy create odoo16ee test
````

If everything went well, you can now go back to your Browser and enjoy http://test.

Explanation
-----------

`deploy` has to modes: _create_ and _remove_

`create` requires two arguments: _deployment template_ and _deployment name_
_deployment templates_ can be found in the tempaltes folder and are simply docker compose setups. On creation they get copyied to deployment folder and a new nginx file is created for resolving and certificates.
Next to odoo, there is a mailcatcher with a webinterface on Port `8025`.
From odoo, use `mailhog` as SMTP Server and Port `1025`.
custom modules go into the following directory: `./deployments/[deploymentname]/extra-addons`

`remove` takes only one arguemnt: the deployment. As the name sugests it removes the deployment. Kepp in mind that it doesn't remove the volumes (where the data is stored). So if you delete a deployment and create a new one by the same name you're old databases and filestore are back. You can delete them in Docker Desktop in the Volume tab.



