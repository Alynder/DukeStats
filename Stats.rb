#!/usr/bin/env ruby

require "net/ssh"
require "tty/prompt"

prompt =TTY::Prompt.new

howmany= prompt.ask('How many machines are you checking on today?')


def run

prompt =TTY::Prompt.new

 #Gather information
 host= prompt.ask('Please enter hostname or IP')
 user= prompt.ask('Please enter username')
 pass= prompt.mask('Please enter password')



Net::SSH.start(host, user, :password => pass,:timeout => 15) do |ssh|
  # capture all stderr and stdout output from a remote process
  hostname = ssh.exec!("hostname")
  os = ssh.exec!("uname")
  ver = ssh.exec!("cat /etc/*-release")
  up = ssh.exec!("uptime")
  hdd = ssh.exec!("df -h /")
  mem = ssh.exec!("free -h")
  proc= ssh.exec!("cat /proc/cpuinfo | grep -c ^processor")

  today= Time.new.strftime("%Y%m%d")

  File.open("/output/#{host}.#{today}",'w'){ |p|
  p.print "hostname: " 
  p.puts hostname
  p.print "OS: "
  p.puts os
  p.print "OS Version: "
  p.puts ver
  p.print "Uptime: "
  p.puts up
  p.print "Hard Drive Space: "
  p.puts hdd
  p.print "Free Memory: "
  p.puts mem
  p.print "Number of Cpu's: "
  p.puts proc
}

  end
 rescue =>e 
   puts "Error: #{host} #{e.message}" 
end
  

howmany.to_i.times{run}
