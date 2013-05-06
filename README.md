p5-nginx-minify
===============

Nginx Perl Minify [CSS / JS / HTML5]

Depending
===============
**FreeBSD**
```bash
$ portmaster textproc/p5-CSS-Minifier-XS textproc/p5-JavaScript-Minifier-XS textproc/p5-HTML-Packer
```
**Ubuntu/Debian**
```bash
apt-get install libcss-minifier-xs-perl libjavascript-minifier-xs-perl libhtml-packer-perl
```

**Manual**:
* [p5-CSS-Minifier-XS](http://search.cpan.org/dist/CSS-Minifier-XS/lib/CSS/Minifier/XS.pm)
* [p5-JavaScript-Minifier-XS](http://search.cpan.org/dist/JavaScript-Minifier-XS/lib/JavaScript/Minifier/XS.pm)
* [p5-HTML-Packer](http://search.cpan.org/dist/HTML-Packer/lib/HTML/Packer.pm) ([in github](https://github.com/nevesenin/html-packer-perl))

```bash
wget http://search.cpan.org/CPAN/authors/id/G/GT/GTERMARS/CSS-Minifier-XS-0.08.tar.gz
tar zxpfv CSS-Minifier-XS-0.08.tar.gz
cd CSS-Minifier-XS-0.08
perl Makefile.PL && make && make install

wget http://search.cpan.org/CPAN/authors/id/G/GT/GTERMARS/JavaScript-Minifier-XS-0.09.tar.gz
tar zxpfv JavaScript-Minifier-XS-0.09.tar.gz
cd JavaScript-Minifier-XS-0.09
perl Makefile.PL && make && make install

wget http://search.cpan.org/CPAN/authors/id/N/NE/NEVESENIN/HTML-Packer-1.004001.tar.gz
tar zxpfv HTML-Packer-1.004001.tar.gz
cd HTML-Packer-1.004001
perl Makefile.PL && make && make install
```

Install
===============
nginx.conf -> /etc/nginx/nginx.conf<br>
mkdir /etc/nginx/perl<br>
Minify.pm -> /etc/nginx/perl/

TODO
===============
* […] $content_type = "text/html" on fastcgi/proxy after compress
* […] algorithm cache select path for static

Known Problems
===============
http://wiki.nginx.org/HttpPerlModule#Known_Problems
* If a Perl module performs protracted operation, (for example DNS lookups, database queries, etc), then the worker process that is running the Perl script is completely tied up for the duration of script. Therefore embedded Perl scripts should be extremely careful to limit themselves to short, predictable operations.
* It's possible for Nginx to leak memory if you reload the configuration file (via 'kill -HUP <pid>').
