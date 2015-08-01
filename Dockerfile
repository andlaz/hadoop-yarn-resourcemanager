FROM andlaz/hadoop-base
MAINTAINER andras.szerdahelyi@gmail.com

RUN yum -y install ruby-2.0.0.598 \
		rubygems-2.0.14

RUN gem install thor

ADD etc/supervisor/conf.d/* /etc/supervisor/conf.d/

# System ports ( ssh )
EXPOSE 22

# YARN Resource Manager ports ( web ui; scheduler; "web app"; "web app" https; resource tracker; admin ui )
EXPOSE 8032 8030 8088 8090 8031 8033

ADD configure.rb /root/
ADD entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
