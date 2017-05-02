#!/bin/bash

# sed -i "s,http://archive.ubuntu.com/,http://au.archive.ubuntu.com/,g" /etc/apt/sources.list
apt-get update
# apt-get dist-upgrade -y

apt-get install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
echo 'set background=dark' >> /home/vagrant/.vimrc

# Install dependencies according to 'Hadoop: Setting up a Single Node Cluster'
# See https://hadoop.apache.org/docs/r2.7.2/hadoop-project-dist/hadoop-common/SingleCluster.html
apt-get install -y openjdk-7-jdk ssh rsync

mkdir -p /vagrant/cache

# See latest Hadoop downloads at http://www.apache.org/dyn/closer.cgi/hadoop/common/.
if [[ ! -e '/opt/hadoop-2.7.2' ]]; then
  wget -c -P /vagrant/cache 'http://apache.mirror.digitalpacific.com.au/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz'
  tar -x -z -C /opt -f '/vagrant/cache/hadoop-2.7.2.tar.gz'
  chown -R vagrant: '/opt/hadoop-2.7.2'
  ln -s 'hadoop-2.7.2' '/opt/hadoop'
  echo 'export PATH="/opt/hadoop/bin:$PATH"' >> /home/vagrant/.bashrc

  sed -i "s,JAVA_HOME=.*,JAVA_HOME='/usr/bin/java'," /opt/hadoop/etc/hadoop/hadoop-env.sh
  sudo -u vagrant cp '/vagrant/files/core-site.xml' '/opt/hadoop/etc/hadoop/core-site.xml'
  sudo -u vagrant cp '/vagrant/files/hdfs-site.xml' '/opt/hadoop/etc/hadoop/hdfs-site.xml'
  sudo -u vagrant cp '/vagrant/files/mapred-site.xml' '/opt/hadoop/etc/hadoop/mapred-site.xml'
  sudo -u vagrant cp '/vagrant/files/yarn-site.xml' '/opt/hadoop/etc/hadoop/yarn-site.xml'
fi
if [[ ! -e '/opt/spark-1.6.3-bin-hadoop2.6' ]]; then
  wget -c -P /vagrant/cache 'http://www.us.apache.org/dist/spark/spark-1.6.3/spark-1.6.3-bin-hadoop2.6.tgz'
  tar -x -z -C /opt -f '/vagrant/cache/spark-1.6.3-bin-hadoop2.6.tgz'
  chown -R vagrant: '/opt/spark-1.6.3-bin-hadoop2.6'
  ln -s 'spark-1.6.3-bin-hadoop2.6' '/opt/spark'
  echo 'export PATH="/opt/spark/bin:$PATH"' >> /home/vagrant/.bashrc
fi
if [[ ! -e '/opt/elasticsearch-1.7.5' ]]; then
  wget -c -P /vagrant/cache 'https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.5.tar.gz'
  tar -x -z -C /opt -f '/vagrant/cache/elasticsearch-1.7.5.tar.gz'
  chown -R vagrant: '/opt/elasticsearch-1.7.5'
  ln -s 'elasticsearch-1.7.5' '/opt/elasticsearch'
  echo 'export PATH="/opt/elasticsearch/bin:$PATH"' >> /home/vagrant/.bashrc
fi
if [[ ! -e '/opt/hBase-1.2.4' ]]; then
  wget -c -P /vagrant/cache 'http://www-us.apache.org/dist/hbase/1.2.4/hbase-1.2.4-bin.tar.gz'
  tar -x -z -C /opt -f '/vagrant/cache/hbase-1.2.4-bin.tar.gz'
  chown -R vagrant: '/opt/hbase-1.2.4'
  ln -s 'hbase-1.2.4' '/opt/hbase'
  echo 'export PATH="/opt/hbase/bin:$PATH"' >> /home/vagrant/.bashrc
fi

if [[ ! -e '/opt/apache-predictionio-0.10.0-incubating' ]]; then
  wget -c -P /vagrant/cache 'http://www-us.apache.org/dist/incubator/predictionio/0.10.0-incubating/apache-predictionio-0.10.0-incubating.tar.gz'
  tar -x -z -C /opt -f '/vagrant/cache/apache-predictionio-0.10.0-incubating.tar.gz'
  chown -R vagrant: '/opt/apache-predictionio-0.10.0-incubating'
  ln -s 'apache-predictionio-0.10.0-incubating' '/opt/predictionio10'
  echo 'export PATH="/opt/predictionio10/bin:$PATH"' >> /home/vagrant/.bashrc
fi



# if [[ ! -e '/opt/predictionIO-0.9.7-aml' ]]; then
#   wget -c -P /vagrant/cache 'http://www-us.apache.org/dist/hbase/1.2.4/hbase-1.2.4-bin.tar.gz'
#   tar -x -z -C /opt -f '/vagrant/cache/PredictionIO-0.9.7-aml.tar.gz'
#   chown -R vagrant: '/opt/predictionIO-0.9.7-aml'
#   ln -s 'hbase-1.2.4' '/opt/predictionio'
#   echo 'export PATH="/opt/predictionio/bin:$PATH"' >> /home/vagrant/.bashrc
# fi

sudo -u vagrant cp '/vagrant/files/run-example.sh' '/home/vagrant/run-example.sh'
