# hier die Pakete für SDL
use SDL;
use SDL::Video;
use SDL::Surface;
use SDL::Rect;

# Network
use Net::PcapUtils;
use NetPacket::Ethernet qw(:strip);
use NetPacket::IPv6;

# Rest
use strict;
use warnings;

$SIG{INT}  = \&signal_handler;
$SIG{TERM} = \&signal_handler;

# the size of the window box or the screen resolution if fullscreen
my $screen_width   = 800;
my $screen_height  = 600;

SDL::init(SDL_INIT_VIDEO);

# setting video mode
my $screen_surface = SDL::Video::set_video_mode($screen_width, $screen_height, 32, SDL_SWSURFACE);

sub process_pkt {
    my ($user, $hdr, $pkt) = @_;
    my $ip6_obj = NetPacket::IPv6->decode(eth_strip($pkt));
    my @pixel_data = split(':', "$ip6_obj->{dest_ip} \n");
    my $rg = sprintf ("%04s", $pixel_data[6]);
    my $ba = sprintf ("%06s", $pixel_data[7]); # hier sind 2 Zeichen wegen dem Zeilenende drin. Die s    ollten evtl. vorher rausgefiltert werden.

    # Mache aus allem Dezimale Zahlen zur Weitergabe
    my $dX=hex($pixel_data[4]);
    my $dY=hex($pixel_data[5]);
    my $dRed=hex(substr($rg, 0, 2));
    my $dGreen=hex(substr($rg, 2, 2));
    my $dBlue=hex(substr($ba, 0, 2));
#    my $dAlpha=hex(substr($ba, 2, 2));
    my $dAlpha=255;

    print "--------\n";

    print("$ip6_obj->{dest_ip} \n");

    print "rg: ", $rg, "ba: ", $ba, "dX: $dX", "dY: $dY", "dRed: $dRed", "dGreen: $dGreen", "dBlue: $dBlue", "dAlpha: $dAlpha \n";

    if (($dX<=$screen_width) && ($dY<=$screen_height) && (hex($pixel_data[4]) >1) && (hex($pixel_data[5])>1)) {
        print "Bedingung trifft zu\n";

        my $pixel0 = SDL::Video::map_RGB( $screen_surface->format(), $dRed, $dGreen, $dBlue);
        SDL::Video::fill_rect($screen_surface, SDL::Rect->new($dX,$dY,1,1),$pixel0);


        my @rects = ();
        push(@rects, SDL::Rect->new($dX, $dY, 1, 1));

        # updating parts of the screen (should look like a cross)
        SDL::Video::update_rects($screen_surface, @rects);
    }

    sub signal_handler {
        die "Caught a signal $!";
    }
}
Net::PcapUtils::loop(\&process_pkt, FILTER => 'ip6');

#while (1) {
#    Net::PcapUtils::loop(\&process_pkt, FILTER => 'ip6');
#
#    my $pixel0 = SDL::Video::map_RGB( $screen_surface->format(), $r0, $g0, $b0);
#    SDL::Video::fill_rect($screen_surface, SDL::Rect->new($x0,$y0,1,1),$pixel0);
#
#
#    my @rects = ();
#    push(@rects, SDL::Rect->new($x0, $y0, 1, 1));
#    #push(@rects, SDL::Rect->new(200,   0, 400, 600));
#    #push(@rects, SDL::Rect->new(  0, 150, 800, 300));
#
#    # updating parts of the screen (should look like a cross)
#    SDL::Video::update_rects($screen_surface, @rects);
#
##    sleep(0.1);
#};
