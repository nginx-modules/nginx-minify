package Minify;
use nginx;
use JavaScript::Minifier::XS;
use CSS::Minifier::XS;
use HTML::Packer;

sub html_handler {
    my $r = shift;
    my $cache_file = $r->filename;
    $cache_file =~ s/.html/.min.html/gi;
    my $filename = $r->filename;
    local $/=undef;

    return DECLINED unless -f $filename;

    open(INFILE, $filename) or die "Error reading file: $!";
    my $html = <INFILE>;
    close(INFILE);

    open(OUTFILE, '>' . $cache_file) or die "Error writing file: $!";
    print OUTFILE HTML::Packer::minify(\$html, {  remove_comments => 1,  remove_newlines => 1,  no_compress_comment => 1,  html5 => 1  });
    close(OUTFILE);

    $r->send_http_header('text/html');
    $r->sendfile($cache_file);
    return OK;
}

sub css_handler {
    my $r = shift;
    my $cache_file = $r->filename;
    $cache_file =~ s/.css/.min.css/gi;
    my $filename = $r->filename;
    local $/=undef;

    return DECLINED unless -f $filename;

    open(INFILE, $filename) or die "Error reading file: $!";
    my $css = <INFILE>;
    close(INFILE);

    open(OUTFILE, '>' . $cache_file) or die "Error writing file: $!";
    print OUTFILE CSS::Minifier::XS::minify($css);
    close(OUTFILE);

    $r->send_http_header('text/css');
    $r->sendfile($cache_file);
    return OK;
}

sub js_handler {
    my $r = shift;
    my $cache_file = $r->filename;
    $cache_file =~ s/.js/.min.js/gi;
    my $filename = $r->filename;
    local $/=undef;

    return DECLINED unless -f $filename;

    open(INFILE, $filename) or die "Error reading file: $!";
    my $js = <INFILE>;
    close(INFILE);

    open(OUTFILE, '>' . $cache_file) or die "Error writing file: $!";
    print OUTFILE JavaScript::Minifier::XS::minify($js);
    close(OUTFILE);

    $r->send_http_header('application/javascript');
    $r->sendfile($cache_file);
    return OK;
}

1;