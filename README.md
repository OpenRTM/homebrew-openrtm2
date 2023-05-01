<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Homebrew_logo.svg/159px-Homebrew_logo.svg.png" align="right">

# homebrew-openrtm2
This is [homebrew](https://brew.sh/) tap repository including OpenRTM2 and related formula.

Currently the following versions of OpenRTM-aist are provided.

- OpenRTM-aist-2.0.1
  - C++ version
    - on Python 3.8, 3.9, 3.10, 3.11 (omniidl depeneds on python)
  - Python version
    - on Python 3.8, 3.9, 3.10, 3.11
  - Java version
    - needs Java8 (adoptopenjdk8) because of CORBA
  - OpenRTP2 (RTCBuildler, RTSystemEditor on Eclipse)
    - needs Java8 (adoptopenjdk8) because of CORBA
  - rtshell
    - managed by pip

These packages supports the following macOS versions

- Big Sur, Monterey, Ventura

## How to install

### OpenRTM-aist (C++)

Please install the omniORB bottle "[omniorb-ssl](https://github.com/OpenRTM/homebrew-omniorb)" provided us instead of official "omniorb" bottle. This package automatically installed as a dependency.
```shell
$ brew update
$ brew uninstall omniorb  <--- if you already installed omniorb
$ brew tap openrtm
$ brew install openrtm2-py311 (if you still use Python 3.11)
$ brew link openrtm2-py311
and then please try to run sample components 
$ /usr/local/share/openrtm-2.0/components/c++/examples/ConsoleInComp
```

### OpenRTM-aist (Python)
Please install the omniORBpy bottle "[omniorbpy](https://github.com/OpenRTM/homebrew-omniorb)" provided us. This package is automatically installed as a dependency.
```shell
$ brew update
$ brew install openrtm/openrtms/openrtm2-python-py310 (if you still use Python 3.10)
$ brew link openrtm-aist-python
and then please try to run sample components
$ python3 /usr/local/share/openrtm-2.0/components/python3/SimpleIO/ConsoleIn.py 
```

### OpenRTM-aist (Java)
Java8 is necesarry for OpenRTM-aist-Java and OpenRTP. The adoptopenjdk8 will be installed automatically. 
```shell
$ brew update
$ brew cask install adoptopenjdk8
$ brew install openrtm/openrtm2/openrtm2-java
$ cat /usr/local/etc/profile.d/openrtm-aist-java.sh >> ~/.profile
$ source ~/.profile
and then please try to run sample components
$ /usr/local/share/openrtm-2.0/components/java/ConsoleIn.sh
```

### OpenRTP-aist (Eclipse tool)
Due to the OpenRTP dependency, the Cask of Eclipse Temurin8 is required.

```shell
$ brew update
$ brew tap openrtm/openrtm2
$ brew install --cask homebrew/cask-versions/temurin8   <- Installing Java8
$ brew install openrtp2     <- English version
$ brew install openrtp2-ja  <- Japanese version
$ open -a OpenRTP2-en
or
$ open -a OpenRTP2-ja
```
or launch OpenRTP from "Applications".

 
When opening OpenRTP, the following dialog window might appear.
In that case, please click the "Open" button.

![Screen Shot 2020-10-27 at 15 59 16](https://user-images.githubusercontent.com/11814060/97267621-ca54f780-186d-11eb-9d88-6a41258286fd.png)

If the "Open" button does not exist, please open the "System Preferences" and go to the "Security and Privacy", "General" submenu.
Here please click the "Allow" button to give the privilege to execute the target application.



