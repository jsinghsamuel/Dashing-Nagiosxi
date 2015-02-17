# Dashing-Nagiosxi

Dashing-Nagiosxi is a Nagiosxi widget for Shopify's dashing framework. The Widgets provides the Overall Service/Host Status and on clicking it gives Detailed View.

This repository contains the nagiosxi widget, a sample dashboard showing the Overall Service/Host Status and another widget is called on Click Event which shows more details Service/Host Status Counts. It contains jobs to fetch data from one Nagiosxi machines.

The Jobs uses the Nagiosxi backendAPI URLS for fetching the data from Nagiosxi machines. Use the below link to activate the APIs for users (http://assets.nagios.com/downloads/nagiosxi/docs/Accessing_The_XI_Backend_API.pdf). 

# Dependencies

Add the following to your Gemfile
```
gem 'open-uri'
gem 'nokogiri'
```
And run 
```
bundle install
```

# Usage

Copy the contents of dashboard, jobs and widgets directories to your dashing installation.

Edit `hostStatusURL`, `hostServiceURL` into `nagiosxi.rb` and `nagiosxidetails.rb` with the Nagiosxi APIs URL details. 

Screenshot
==========
![image](https://raw.githubusercontent.com/jsinghsamuel/Dashing-Nagiosxi/master/assets/images/nagiosxi.png)

![image](https://raw.githubusercontent.com/jsinghsamuel/Dashing-Nagiosxi/master/assets/images/nagiosxidetails.png)


