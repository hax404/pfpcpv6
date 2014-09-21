Beschreibung: PixelFlut Pixel Controll Protocoll over ipV6
Name: PFPCPV6
#Pixelflut #Protokoll der #Zukunft über #IPv6 fe80::XXXX:YYYY:RRGG:BBAA #mrmcd @xAndy
Die Idee von diesem Protokoll ist auf der MRMCD14 eskalliert.

Welche Angaben brauchen wir vom Client?
* Koordinaten X,Y
  * Auflösung eines künftigen Raspi muss unterstützt werden
* R,G,B-Werte + Alphakanal

Ziel:
* wir haben 64bit im Hostteil Platz
::XXXX:YYYY:RRGG:BBAA/64

Vorteile:
* alles wird in der Adresse untergebracht
* maximale Auflösung bei 65536 * 65536
  * Auflösung eines künftigen Raspi wird unterstützt

Nachteile:
* ein /64er Netz reicht nur für eine Anzeige


