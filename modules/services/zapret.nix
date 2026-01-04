{ config, lib, pkgs, ... }:

{
  services.zapret = {
    enable = true;
    udpSupport = true;
    udpPorts = [ "443" "19294:19344" "50000:50100" ];
    params = [
      "--filter-udp=443 --hostlist=/opt/zapret/ipset/zapret-hosts-user.txt --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic=/opt/zapret/files/fake/quic_initial_www_google_com.bin --new"
      "--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new"
      "--filter-tcp=80 --hostlist=/opt/zapret/ipset/zapret-hosts-user.txt --dpi-desync=fake,multisplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new"
      "--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin --new"
      "--filter-tcp=443 --hostlist=/opt/zapret/ipset/zapret-hosts-user.txt --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls=/opt/zapret/files/fake/tls_clienthello_www_google_com.bin"
    ];
  };
}
