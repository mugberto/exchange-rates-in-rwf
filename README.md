# EXCHANGE RATES IN RWANDA

A scraper app that extracts exchange rates from Rwanda National Bank website (bnr.rw)
Extracted data are saved in csv file and displayed in terminal. 
In fact, This app extracts data from 2 websites:
1. bnr.rw : a list of exchange rates and currency codes
2. pkgstore.datahub.io : a list of country names and currency codes
It adds country name to the exchange rates list by matching currency codes

## Required installations
This app requires the following packages to be installed on you system:

* Ruby 2.7.0
* Gem 3.1.2

## Setup configurations

To get this app ready to run, follow this steps:

* clone this repo

        pc:~$ git clone git@github.com:mugberto/exchange-rates-in-rwf.git

* move into the root directory

        pc:~$ cd exchange-rates-in-rwf/

* install require gems

        pc:~$ gem install nokogiri -v 1.10.10
        
        pc:~$ gem install selenium-webdriver -v 3.142.7

## How to use it

Once you have all you require packages and gems installed. 
Open your terminal in the root directory and enter this command:

    pc$ ruby run.rb
 ​
## Contributing

Contributions, issues and feature requests are welcome!
​
Feel free to check the [issues page](https://github.com/mugberto/tic-tac-toe/issues).
​

## Show your support

Please, give a ⭐️ if you like this project!

## Author
​
#### 👤 **Hubert MUGABO**
​
- Github: [@mugberto](https://github.com/mugberto)
- Twitter: [@mugberto](https://twitter.com/mugberto)
- Linkedin: [mugberto](https://www.linkedin.com/in/hubert-mugabo-23144b6a/)

## Acknowledgement

- Microverse
- The open source community