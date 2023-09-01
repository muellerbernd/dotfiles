#!/usr/bin/env python3
import dbus
bus = dbus.SessionBus()
#  print(bus.list_names())
for service in bus.list_names():
    #  if service.startswith('org.mpris.MediaPlayer2.') and "spotify" not in service:
    if service.startswith('org.mpris.MediaPlayer2.') and "spotify" in service:
        player = dbus.SessionBus().get_object(service, '/org/mpris/MediaPlayer2')
        interface = dbus.Interface(player, dbus_interface='org.mpris.MediaPlayer2.Player')
        test=interface.PlayPause()
        print(service,test)
        #  property_interface = dbus.Interface(player, dbus_interface='org.freedesktop.DBus.Properties')
        #  print(player)
        #  for property, value in property_interface.GetAll('org.mpris.MediaPlayer2.Player').items():
        #      print(property, ':', value)

        #  status=property_interface.Get('org.mpris.MediaPlayer2.Player', 'Volume')
        #  print(status)
        #
        #  metadata = player.Get('org.mpris.MediaPlayer2.Player', 'Metadata', dbus_interface='org.freedesktop.DBus.Properties')
        #  print(metadata)
