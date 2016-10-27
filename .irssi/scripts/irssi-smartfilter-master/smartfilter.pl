use strict;
use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "0.3"; # local modified version to disable the filter on join, part and quit signals when there is less than a certain amount of people in the channel

%IRSSI = (
	authors     => 'Christian Brassat and Walter Hop',
	contact     => 'irssi-smartfilter@spam.lifeforms.nl',
	name        => 'smartfilter.pl',
	description => 'Smart filter for join, part, quit, nick messages',
	license     => 'BSD',
	url         => 'https://github.com/lifeforms/irssi-smartfilter',
	changed     => '2014-01-02',
);

# Associative array of nick => last active unixtime
# TODO: garbage collect, any entries older than smartfilter_delay can be safely removed
our $lastmsg = {};

# Do checks after receving a channel event.
# - If the originating nick is not active, ignore the signal.
# - If nick is active, propagate the signal and display the event message.
#   Keep the nick marked as active, so we will not miss a re-join after a PART
#   or QUIT, a second nick change, etc.
# - If the nick is in a channel with less than a certain number of user, propagate the message (even if not active)
sub checkactive {
	my ($nick, $altnick, $channel, $server) = @_;
        if ($lastmsg->{$nick} <= time() - Irssi::settings_get_int('smartfilter_delay')) {
            # if $server exists (JOIN, PART or QUIT signal)
            if ( defined($server)) {
                my @channels_array;
                # if $channel exists (JOIN or PART signal)
                if ( defined($channel)) {
                    #contains only one channel
                    @channels_array = $server->window_item_find("$channel");
                }
                # (QUIT signal)
                else {
                    @channels_array = $server->channels();
                }
                #minimum number of users in a channel to stop the signal
                my $min_nicks = Irssi::settings_get_int('smartfilter_min_users');
                # don't stop signal if there is less than -a minimum number of user- in one of the channel of the server where the user is
                foreach my $channel (@channels_array) {
                    if ( defined $channel->nick_find($nick)) {
                        my @nicks_array = $channel->nicks();
                        my $nicks_counts = @nicks_array;
                        if( $nicks_counts < $min_nicks) {
                            return;
                        }
                    }
                }
            }
            Irssi::signal_stop();
        } else {
            $lastmsg->{$nick} = time();
            if ($altnick) {
                $lastmsg->{$altnick} = time();
            }
        }
}

# JOIN or PART received.
sub smartfilter_chan {
	my ($server, $channel, $nick, $address) = @_;
	&checkactive($nick, undef, $channel, $server);
};

# QUIT received.
sub smartfilter_quit {
	my ($server, $nick, $address, $reason) = @_;
	&checkactive($nick, undef, undef, $server);
};

# NICK change received.
sub smartfilter_nick {
	my ($server, $newnick, $nick, $address) = @_;
	&checkactive($nick, $newnick, undef, undef);
};

# Channel message received. Mark the nick as active.
sub log {
	my ($server, $msg, $nick, $address, $target) = @_;
	$lastmsg->{$nick} = time();
}

Irssi::signal_add('message public', 'log');
Irssi::signal_add('message join', 'smartfilter_chan');
Irssi::signal_add('message part', 'smartfilter_chan');
Irssi::signal_add('message quit', 'smartfilter_quit');
Irssi::signal_add('message nick', 'smartfilter_nick');

Irssi::settings_add_int('smartfilter', 'smartfilter_delay', 900);
Irssi::settings_add_int('smartfilter', 'smartfilter_min_users', 20);
