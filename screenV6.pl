#!/usr/bin/perl -w

use strict;
use warnings;
use Socket; # For constants like AF_INET and SOCK_STREAM

#my $proto = getprotobyname('tcp');    #get the tcp protocol

# 1. create a socket handle (descriptor)
#my($sock);
#socket($sock, AF_INET, SOCK_STREAM, $proto) or die $!;

# 2. connect to remote server
my $remote = '2001:db8:affe:affe';
#my $port = 8080;

#my $iaddr = inet_aton($remote) or die "Unable to resolve hostname : $remote";
#my $paddr = sockaddr_in($port, $iaddr);    #socket address structure

#connect($sock , $paddr) or die "connect failed : $!";
#print "Connected to $remote on port $port\n";

# 3. Send some data to remote server - the HTTP get command
my $maxwidth=800;
my $maxheight=600;
my %colors = (
  "aliceblue" => "F0F8FF",
  "antiquewhite" => "FAEBD7",
  "aquamarine" => "7FFFD4",
  "azure" => "F0FFFF",
  "beige" => "F5F5DC",
  "blueviolet" => "8A2BE2",
  "brown" => "A52A2A",
  "burlywood" => "DEB887",
  "cadetblue" => "5F9EA0",
  "chartreuse" => "7FFF00",
  "chocolate" => "D2691E",
  "coral" => "FF7F50",
  "cornflowerblue" => "6495ED",
  "cornsilk" => "FFF8DC",
  "crimson" => "DC143C",
  "darkblue" => "00008B",
  "darkcyan" => "008B8B",
  "darkgoldenrod" => "B8860B",
  "darkgray" => "A9A9A9",
  "darkgreen" => "006400",
  "darkkhaki" => "BDB76B",
  "darkmagenta" => "8B008B",
  "darkolivegreen" => "556B2F",
  "darkorange" => "FF8C00",
  "darkorchid" => "9932CC",
  "darkred" => "8B0000",
  "darksalmon" => "E9967A",
  "darkseagreen" => "8FBC8F",
  "darkslateblue" => "483D8B",
  "darkslategray" => "2F4F4F",
  "darkturquoise" => "00CED1",
  "darkviolet" => "9400D3",
  "deeppink" => "FF1493",
  "deepskyblue" => "00BFFF",
  "dimgray" => "696969",
  "dodgerblue" => "1E90FF",
  "firebrick" => "B22222",
  "floralwhite" => "FFFAF0",
  "forestgreen" => "228B22",
  "gainsboro" => "DCDCDC",
  "ghostwhite" => "F8F8FF",
  "gold" => "FFD700",
  "goldenrod" => "DAA520",
  "greenyellow" => "ADFF2F",
  "honeydew" => "F0FFF0",
  "hotpink" => "FF69B4",
  "indianred" => "CD5C5C",
  "indigo" => "4B0082",
  "ivory" => "FFFFF0",
  "khaki" => "F0E68C",
  "lavender" => "E6E6FA",
  "lavenderblush" => "FFF0F5",
  "lawngreen" => "7CFC00",
  "lemonchiffon" => "FFFACD",
  "lightblue" => "ADD8E6",
  "lightcoral" => "F08080",
  "lightcyan" => "E0FFFF",
  "lightgoldenrodyellow" => "FAFAD2",
  "lightgreen" => "90EE90",
  "lightgrey" => "D3D3D3",
  "lightpink" => "FFB6C1",
  "lightsalmon" => "FFA07A",
  "lightseagreen" => "20B2AA",
  "lightskyblue" => "87CEFA",
  "lightslategray" => "778899",
  "lightsteelblue" => "B0C4DE",
  "lightyellow" => "FFFFE0",
  "limegreen" => "32CD32",
  "linen" => "FAF0E6",
  "mediumaquamarine" => "66CDAA",
  "mediumblue" => "0000CD",
  "mediumorchid" => "BA55D3",
  "mediumpurple" => "9370DB",
  "mediumseagreen" => "3CB371",
  "mediumslateblue" => "7B68EE",
  "mediumspringgreen" => "00FA9A",
  "mediumturquoise" => "48D1CC",
  "mediumvioletred" => "C71585",
  "midnightblue" => "191970",
  "mintcream" => "F5FFFA",
  "mistyrose" => "FFE4E1",
  "moccasin" => "FFE4B5",
  "navajowhite" => "FFDEAD",
  "oldlace" => "FDF5E6",
  "olivedrab" => "6B8E23",
  "orange" => "FFA500",
  "orangered" => "FF4500",
  "orchid" => "DA70D6",
  "palegoldenrod" => "EEE8AA",
  "palegreen" => "98FB98",
  "paleturquoise" => "AFEEEE",
  "palevioletred" => "DB7093",
  "papayawhip" => "FFEFD5",
  "peachpuff" => "FFDAB9",
  "peru" => "CD853F",
  "pink" => "FFC0CB",
  "plum" => "DDA0DD",
  "powderblue" => "B0E0E6",
  "rosybrown" => "BC8F8F",
  "royalblue" => "4169E1",
  "saddlebrown" => "8B4513",
  "salmon" => "FA8072",
  "sandybrown" => "F4A460",
  "seagreen" => "2E8B57",
  "seashell" => "FFF5EE",
  "sienna" => "A0522D",
  "skyblue" => "87CEEB",
  "slateblue" => "6A5ACD",
  "slategray" => "708090",
  "snow" => "FFFAFA",
  "springgreen" => "00FF7F",
  "steelblue" => "4682B4",
  "tan" => "D2B48C",
  "thistle" => "D8BFD8",
  "tomato" => "FF6347",
  "turquoise" => "40E0D0",
  "violet" => "EE82EE",
  "wheat" => "F5DEB3",
  "whitesmoke" => "F5F5F5",
  "yellowgreen" => "9ACD32",
);

#my $ = int(rand($maxheight));
my $hrange = int(rand(100));
my $sheight = int(rand($maxheight));

my $wrange = int(rand(100));
my $swidth = int(rand($maxwidth));

my $random_color = $colors{(keys %colors)[rand keys %colors]};
#my $random_alpha = sprintf("%x",int(rand(255)));
#my $random_alpha = "FF";

socket("flood", PF_INET, SOCK_DGRAM, 17);

for (my $height=$sheight; $height<=($sheight+$hrange); $height=$height+1){
  for (my $width=$swidth; $width<=($swidth+$wrange); $width=$width+1){
   # my $doit=int(rand(1));
   # if $doit==1{

#my $random_color = $colors{(keys %colors)[rand keys %colors]};
#my $random_alpha = sprintf("%x",int(rand(255)));
my $random_alpha = "unset";
my $rg = substr($random_color, 0, 4);
my $ba = join("", substr($random_color, 5, 2), "ff");
print "height range:	", $hrange,  "\n";
print "width range:	", $wrange,  "\n";
print "random color:	", $random_color, "\n";
print "random alpha:	", $random_alpha, "\n";
print "rg:		$rg\n";
print "ba:		$ba\n";
#my $color = join("",$random_color,$random_alpha);
my $texttoping = join(":" , $remote, sprintf("%x",$width), sprintf("%x",$height), $rg, $ba);

#system("/usr/bin/ping6 -q -c1 -w 1 -W 1 $texttoping");
#      send($sock , $texttosend , 0);
#      send($sock , "text $width $height EnteEnteEnteEnteEnteEnteEnteEnteEnteEnteEnteEnteEnte\n" , 0);
   # }
    print "sent text:	$texttoping \n";
#send("flood", pack("a128","flood"), 0, pack_sockaddr_in6(53, $texttoping));
system("/usr/bin/sendip -p ipv6 -p udp $texttoping");
sleep(0.2);
    print "--\n";
  }
}
#close($sock);
exit(0);
