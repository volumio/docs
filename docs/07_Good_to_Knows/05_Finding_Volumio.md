## Finding Volumio

When computers talk to each other they need to know each other's IP addresses.
These are awkward for humans to use, so normally we give computers names and
set up a translation between names and IP addresses. This is known as 'name
resolution'.

Volumio uses a system called mDNS (multicast DNS) to advertise its presence
on the LAN. This allows finding it with the name 'volumio.local'. mDNS is
also called 'Bonjour' and 'Zeroconf' by different vendors.

For this to work, you need a client program that can make mDNS queries and
understand the replies.
 * On MacOS and iOS, mDNS is called 'Bonjour' and should Just Work.
 * On Windows, you may need to install [Bonjour](http://www.raspyfi.com/wp-content/uploads/BonjourSetup.exe)
 * On Linux, it will most likely work if you have the 'avahi' packages installed.
 * On Android, there is a problem. At present there is no native support for mDNS
   but you may be able to install an App to help, such as
   [FING](https://play.google.com/store/apps/details?id=com.overlook.android.fing).

mDNS is a relatively new system and not suitable for all situations.
It uses the special '.local' domain. The next section describes how
traditional name resolution works.

To check if mDNS is working on a Linux computer you can try using these
programs from the'avahi-utils' package:
```shell
$ avahi-resolve -n volumio.local
```
and
```shell
$ avahi-browse -a
```

### Translating names to IP addresses without mDNS

Traditional name resolution works differently.
Instead of listening for advertisements broadcast to all computers on the local
network, a computer wanting to resolve a name into an IP address needs to send
a request to a specific computer - a DNS server.
But it has to be configured to use the *right* DNS server.

In a typical home LAN, when a computer (a 'client') connects to the LAN,
your router will give the client an IP address using the DHCP protocol.
As well as an IP address, it usually tells the client which DNS server(s) to use,
and what DNS domain(s) to search when the client machine wants to translate an
'unqualified' name (e.g. 'volumio').

A simple example: suppose your router has the default search domain set to '.lan'.
When your computer wants to look up the IP address associated with the name
'volumio', your computer will actually ask for the name 'volumio.lan'.
Another person's network might have the default domain set to '.home',
so there a computer would ask for 'volumio.home'.
When a lookup of a 'fully-qualified' name is requested (e.g. 'volumio.org'),
the '.lan' is not added to the name. Whatever name is asked for, your computer
will normally ask the DNS server that the router tells it to use.

There are lots of ways this process can go wrong.
 * the router points your computers to DNS servers that do not know anything
   about the the '.lan' or '.home' DNS domain.
 * the DNS server knows about the .lan domain but can't find the name you
   asked for ('volumio').
 * the device you are using may refuse to use the DNS servers the router
   suggests to use. This can happen on Android phones in particular.

There are lots of possible ways to get this 'name resolution' process working,
but which is the right one for you depends on what equipment you have and how
your network is set up. Try to work out how things are failing, then ask in
the forums for help.
