package Minify;
use nginx;
use JavaScript::Minifier::XS;
use CSS::Minifier::XS;
use HTML::Packer;

sub html_handler {
    my $r = shift;
    my $filename = $r->filename;
    local $/=undef;

    return DECLINED unless -f $filename;

    open(INFILE, $filename) or die "Error reading file: $!";
    my $html = <INFILE>;
    close(INFILE);

    $r->send_http_header('text/html');
    $r->print(
        HTML::Packer::minify(
            \$html,
            {
                remove_comments     => 1,
                remove_newlines     => 1,
                no_compress_comment => 1,
                html5               => 1
            }
        )
    );
    return OK;
}

sub css_handler {
    my $r = shift;
    my $filename = $r->filename;
    local $/=undef;

    return DECLINED unless -f $filename;

    open(INFILE, $filename) or die "Error reading file: $!";
    my $css = <INFILE>;
    close(INFILE);

    $r->send_http_header('text/css');
    $r->print(CSS::Minifier::XS::minify($css));
    return OK;
}

sub js_handler {
    my $r = shift;
    my $filename = $r->filename;
    local $/=undef;

    return DECLINED unless -f $filename;

    open(INFILE, $filename) or die "Error reading file: $!";
    my $js = <INFILE>;
    close(INFILE);

    $r->send_http_header('application/javascript');
    $r->print(JavaScript::Minifier::XS::minify($js));
    return OK;
}

1;