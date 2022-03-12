# Thermal Camera

So I was pondering buying a thermal camera from Pimoroni to play with when a friend told me he had one and I could play with it if I didn't break it. Well, I haven't.

My motivation was and still is to find out where my precious heat is disappearing from my house. Especially since the energy companies in UK have got us by the short and curlies and I'm seeing energy usage almost double in cost and set to go up again in April this year.

The Pi had to be powered from one of those portable USB power things so I could put it in my pocket whilst wandering about. It had to have a touch screen so I could press buttons and view the images the camera was producing.

I found the following https://tomshaffner.github.io/PiThermalCam/, programmed my Pi accordingly. Unfortunately, this code expects me to carry around a keyboard. The Pi's virtual keyboard takes up a lot of screen real estate so I decided to use tkInter to produce a display with buttons I could press.

# Hardware:

## Raspberry Pi 4	

I'm using one of these with Bullseye. They have the availablility of hens teeth at the moment. Mine has 4Gb of ram but I think 2Gb would be fine. You might get away with using a Pi 3.

A fresh install of Bullseye, using the Raspberry Pi Imager 1.7.1 on 12th March 2022 has python 3.9 installed. 

## Touch screen

I used a Waveshare 5" CSI touch screen (Try Pimoroni or PiHut)- this seems to self configure on Buster but not on Bullseye - you may need to add some entries to /boot/config.txt as follows:-

```
# Enable DRM VC4 V3D driver
dtoverlay=vc4-fkms-v3d,rpi-ft5406
max_framebuffers=2

```

This monitor is very well made - if you look at the picture of the assembled camera you can see it bolts direct to the Pi. The brass standoffs and screws are provided.

Carrying the camera around generally is problematic if your fingers come into contact with the screen edges because of its touch sensitivity. So, I made some ractangular handles to keep my fingers away from the display.


## Thermal Imaging Camera

As far as I know there's only the Pimoroni offering of wide angle (110 deg) and normal (55 deg).

The wide angle works ok and is really best if you want to use the camera for detecting hot bodies wandering about in your back garden at night.

To mount the thermal camera on the 'front' of the Pi required me to 3D print a bracket to mount the camera on.

##  Camera mounting bracket

The mounting bracket was designed in openSCAD and 3D printed. It allows the camera to be mounted in numerous orientations. Important to get the on-screen image the same way up as the real world.


# Software

## I2C configuration

You need to enable I2C and edit the /boot/config.txt to increase the baudrate to 400000

Use sudo raspi-config to enable I2C or just change this line:-
```
#dtparam=i2c_arm=on
```

to
```
dtparam=i2c_arm=on,i2c_arm_baudrate=400000
```

You should reboot for changes to take effect

## Install the I2C libraries

```
sudo apt-get install libatlas-base-dev python3-smbus i2c-tools 
```

The attach the thermal camera as per https://tomshaffner.github.io/PiThermalCam/images/mlx90640_rpi_wiring_diagram_w_table.png

After rebooting check the camera can be seen:-

```
i2cdetect -y 1
```

You should see the device at address 0x33

## Swap file

Compiling opencv-contrib-python can be a long process and may fail if the swap file (default 100M) becomes full If you don't have enough ram (Mine has 4Gb) you can increase the system swapfile:-

```
sudo dphys-swapfile swapoff
sudo nano /etc/dphys-swapfile

change this CONF_SWAPSIZE=100 - it depends how much memory you have but I set this to 1024 for my 4Gb Pi4.

```
Recreate the swap file and turn it on then reboot the pi

```
sudo dphys-swapfile setup - oddly these two commands open an editor window - just quit
sudo dphys-swapfile swapon
```

If you install libraries in accordance with https://tomshaffner.github.io/PiThermalCam/ on bullseye you may have a problem when you run the software - after hours of waiting for installation to complete the software threw lots of errors on my Bullseye Rpi.


Instead I installed the required libraries manually first but note. If you change opencv-python to opencv-contrib-python it will take a very long time. You might want opencv-contrib-python for other things but it takes ages to install.

I'm using python -m because it ensures stuff gets installed in the correct place for the default version of python. Note: numpy needs to be V1.22.1 or later for python 3.9 on.

```
python -m pip install -r requirements.txt
```

then install pithermalcam

```
python -m pip install pithermalcam
```


Download tk_cam.py and run it with 
```
python tk_cam.py 
```

If you want the program to restart automatically create a systemd launcher because the program is likely to stop running if you touch the edges of the touch screen. Systemd will restart it.


The default makes blue the HOT colour. I had to add code to swap the R&B channels for the screen display so that hot bodies wer red. The original code didn't want to do that even when I tried the rainbow colormap.
