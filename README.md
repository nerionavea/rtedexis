# Rtedexis

This is a solution for integrate a Ruby application with Tedexis SMS delivery Tool
any information for get Tedexis services is in it's website [Tedexis](http://www.tedexis.com)

At the moment only is compatible with two integrations tools for SMS delivery: 

*SOAP
*SFTP

## Getting started

For install this gem you could do running this on your terminal

```console
gem install rtedexis
```
then add this to your Gemfile 

```ruby
gem 'rtedexis'
```

and require it 

```ruby
require  'rtedexis'
```

# SOAP

For individual delivery of SMS you could use SOAP tool on this way


```ruby
Rtedexis.SOAP.new(passport: 'yourpassport', password: 'yourpassword').send('4125491920', 'Text Here!')
```

You don't require to write the cellphone number with '+58' format

#SFTP

For massive sms delivery with SFTP tool you could use this:

```ruby
Rtedexis.SFTP.new(passport: 'yourpassport', password: 'yourpassword').send(['4125491920', '4168605522'], 'Text here')
```
this method recieve an array for the numbers that will delivery the SMS

