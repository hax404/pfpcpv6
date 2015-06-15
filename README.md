Beschreibung: PixelFlut Pixel Controll Protocol over ipV6
Name: PFPCPV6
Die Idee von diesem Protokoll ist auf der MRMCD14 eskalliert. Danke an xAndy.

Welche Angaben brauchen wir vom Client?
* Koordinaten X,Y
  * Auflösung eines künftigen Raspi muss unterstützt werden
* R,G,B-Werte + Alphakanal

Ziel:
* wir haben 64bit im Hostteil Platz
::XXXX:YYYY:RRGG:BBAA/64

Beispiel:
Ein Paket an die Adresse 2001:db8::17:2a:ff8c:00ff färbt das Pixel x=23 y=42 mit dem RGB-Farbwert #ff8c00 mit maximaler Überdeckung ein.

Vorteile:
* alles wird in der Adresse untergebracht
* maximale Auflösung bei 65536 * 65536
  * Auflösung eines künftigen Raspi wird unterstützt

Nachteile:
* ein /64er Netz reicht nur für eine Anzeige (evtl. mehrere Displays nebeneinander betreiben)
* Pixel 0 0 kann nicht mit dem Wert #00000000, also Schwarz mit auf Null gesetzen Alphakanal gesetzt werden
* Pixel 65536 65536 kann nicht auf den Wert #ffffffff, also weiß mit maximalem Alphakanal gesetzt werden

Überlegungen zur Implementation:
* Entgegennehmendes Programm sollte auf einem Router laufen und sein eigenes /64er-Netz geroutet bekommen.
* Pakete mit Alphakanal bei 0 können direkt verworfen werden, da diese keine Änderung erzeugen.

