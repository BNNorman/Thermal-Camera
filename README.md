# Thermal Camera

So I was pondering buying a thermal camera from Pimoroni to play with when a friend told me he had one and I could play with it if I didn't break it. Well, I haven't.

My motivation was and still is to find out where my precious heat is disappearing from my house. Especially since the energy companies in UK have got us by the short and curlies and I'm seeing energy usage almost double in cost and set to go up again in April this year.

The Pi had to be powered from one of those portable USB power things so I could put it in my pocket whilst wandering about. It had to have a touch screen so I could press buttons and view the images the camera was producing.

I found the following https://tomshaffner.github.io/PiThermalCam/, programmed my Pi accordingly. Unfortunately, this code expects me to carry around a keyboard. The Pi's virtual keyboard takes up a lot of screen real estate so I decided to use tkInter to produce a display with buttons I could press.

# Hardware:

## Raspberry Pi 4	

these have the availablility of hens teeth at the moment. Mine has 4Gb of ram but I think 2Gb would be fine. You might get away with using a Pi 3.

## Touch screen

I used a Waveshare 5" CSI touch screen (Try Pimoroni or PiHut)- this seems to self configure on Buster but not on Bullseye - you may need to add some entries to /boot/config.txt

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

Install libraries in accordance with https://tomshaffner.github.io/PiThermalCam/

Download tk_cam.py and run it with 
```
python3 tk_cam.py 
```
or create a systemd launcher because the program is likely to stop running. Systemd will restart it.

I had to add code to swap the R&B channels for the screen display so that hot bodies wer red. The original code didn't want to do that even when I added the rainbow colormap.
