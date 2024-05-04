# Cleaning of old Reolink camera records from FTP storage

The main goal of this script is to automate the process of old Reolink camera records cleaning from FTP storage.  

This repository contains two scripts:
- `cleanup.sh` - contains all logic of removing old records
- `run.sh` - creates a cron job that will run `cleanup.sh` script every day at midnight

## Usage
1. Put `cleanup.sh` and `run.sh` files into your router.
2. Execute `run.sh` file with the source path as a first argument
```shell
./run.sh /path/to/reolink/folder
```
## :heavy_exclamation_mark:Supported routers
- Tested only on the router ASUS RT-AC58U v1 with a stock firmware v3.0.0.4.382_52504

## :heavy_exclamation_mark:Supported Reolink cameras
- Tested only with Reolink Duo 2 WiFi camera
