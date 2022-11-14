from suntime import Sun
from pathlib import Path
from datetime import datetime
import os


## Functions ##

def timeconvert(hour): # Turn hour into a negative number
    if hour >= 13:
        hour -= 24
    return hour

def stringfix(string): # Remove extra quotation marks from the linux output command 
    string = string[1:-2]
    return string

def timefy(integer): # Add zeroes to single digit hours/minutes if needed
    if integer in range(0,10):
        return "0" + str(integer)
    return integer

def ampm(hour, minute): # Change time from 24h to 12h
    new_hour = hour
    if hour in range(0,12):
        timeofday = "AM"
    else:
        new_hour -= 12
        timeofday = "PM"
    return f"{timefy(new_hour)}:{timefy(minute)} {timeofday}"


# Check day/night range
def isday(current_hour, current_minute, sunrise_hour, sunrise_minute, sunset_hour, sunset_minute):
    if sunrise_hour < current_hour < sunset_hour:
        detected = "D"
    elif timeconvert(sunset_hour) < timeconvert(current_hour) < sunrise_hour:
        detected = "N"
    elif (current_hour == sunrise_hour and current_minute >= sunrise_minute):
        detected = "D"
    elif (current_hour == sunrise_hour and current_minute < sunrise_minute):
        detected = "N"
    elif (current_hour == sunset_hour and current_minute >= sunset_minute):
        detected = "N"
    elif (current_hour == sunset_hour and current_minute < sunset_minute):
        detected = "D"
    return detected == "D"


## Program ##

# Setting paths (device setup specific)
path = Path("/home/pixel/.autotheme/")
config = Path("/home/pixel/.config/")
sommelier = Path(f"{config}/systemd/user/sommelier-x@0.service.d/cros-sommelier-x-override.conf")
gtk3_sys = Path("/usr/share/gtk-3.0/")
gtk2_sys = Path("/usr/share/gtk-2.0/")
gtk2_root = Path("/root/")
home = Path("/home/pixel/")
os.system("mkdir -p /home/pixel/.config/systemd/sommelier-x@0.service.d")

# Current time
current_time = str(datetime.now())
current_hour = int(current_time[11:13])
current_minute = int(current_time[14:16])
print(f"Current time: {ampm(current_hour, current_minute)}")

# Sunrise and sunset times (custom)
latitude = 40.4168
longitude = 3.7038

sun = Sun(latitude, longitude)

# Get today's sunrise and sunset in UTC + 2
today_sr = str(sun.get_sunrise_time())
today_ss = str(sun.get_sunset_time())
sunrise_hour = int(today_sr[11:13]) + 2
sunrise_minute = int(today_sr[14:16])
sunset_hour = int(today_ss[11:13]) + 2
sunset_minute = int(today_ss[14:16])
if current_hour > sunrise_hour or (current_hour == sunrise_hour and current_minute >= sunrise_minute):
    os.system(f"echo -e 'Sunrise today: \e[9m{ampm(sunrise_hour, sunrise_minute)}\e[0m (\e[1;31mobsolete, awaiting new data\e[0m)'")
else:
    print(f"Sunrise today: {ampm(sunrise_hour, sunrise_minute)}")

if current_hour > sunset_hour or (current_hour == sunset_hour and current_minute >= sunset_minute):
    os.system(f"echo -e 'Sunset today: \e[9m{ampm(sunset_hour, sunset_minute)}\e[0m (\e[1;31mobsolete, awaiting new data\e[0m)'")
else:
    print(f"Sunset today: {ampm(sunset_hour, sunset_minute)}")
current_theme = stringfix(os.popen("gsettings get org.gnome.desktop.interface gtk-theme").read())


# Apply the themes if needed.
if isday(current_hour, current_minute, sunrise_hour, sunrise_minute, sunset_hour, sunset_minute):
    os.system("echo -e '\e[1;33mDay detected!\e[0m'")
    print("Current theme:", current_theme)
    if current_theme != "adw-gtk3":
        os.system("echo -e '\e[1;32mSwitching to light theme...\e[0m'")
        os.system(f"sh {path}/light-theme.sh")
        os.system(f"cp {path}/gtk2-light {home}/.gtkrc-2.0")
        os.system(f"cp {path}/gtk3-light {config}/gtk-3.0/settings.ini")
        os.system(f"cp {path}/title_color_light.conf {sommelier}")
        
        # Restart Sommelier Service to change titlebar color if needed.
        os.system("systemctl --user daemon-reload")
        os.system("systemctl --user restart sommelier-x@0.service")
    else:
        os.system("echo -e '\e[1;31mLight mode already on, skipped.\e[0m'")

else:
    os.system("echo -e '\e[1;34mNight detected!\e[0m'")
    print("Current theme:", current_theme)
    if current_theme != "adw-gtk3-dark":
        os.system("echo -e '\e[1;32mSwitching to dark theme...\e[0m'")
        os.system(f"sh {path}/dark-theme.sh")
        os.system(f"cp {path}/gtk2-dark {home}/.gtkrc-2.0")
        os.system(f"cp {path}/gtk3-dark {config}/gtk-3.0/settings.ini")
        os.system(f"cp {path}/title_color_dark.conf {sommelier}")

        # Restart Sommelier Service to change titlebar color if needed.
        os.system("systemctl --user daemon-reload")
        os.system("systemctl --user restart sommelier-x@0.service")
    else:
        os.system("echo -e '\e[1;31mDark mode already on, skipped.\e[0m'")

## End of python script :) ##
