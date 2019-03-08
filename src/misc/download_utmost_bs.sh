#!/bin/bash
#PBS -N download_utmost_bs
#PBS -M mundoconspam@gmail.com
#PBS -m a
#PBS -S /bin/bash
#PBS -l walltime=48:00:00
#PBS -l nodes=1:ppn=1
#PBS -l mem=4gb
#PBS -o logs/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs/${PBS_JOBNAME}.e${PBS_JOBID}.err

echo "download 1"
wget --load-cookies /tmp/cookies.txt "https://drive.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies  /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://drive.google.com/uc?export=download&id=1u8CRwb6rZ-gSPl89qm3tKpJArUT8XrEe' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1u8CRwb6rZ-gSPl89qm3tKpJArUT8XrEe" -O sample_data.zip && rm -rf /tmp/cookies.txt
echo "unzip 1"
unzip sample_data.zip

echo "sample data"
mkdir sample_data
cd sample_data
wget --load-cookies /tmp/cookies.txt "https://drive.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies  /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://drive.google.com/uc?export=download&id=1Kh3lHyTioKIXqCsREmsAyC-dS49KVO9G' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Kh3lHyTioKIXqCsREmsAyC-dS49KVO9G" -O covariance_tissue.tar.gz && rm -rf /tmp/cookies.txt
wget --load-cookies /tmp/cookies.txt "https://drive.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies  /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://drive.google.com/uc?export=download&id=1tqIW5Ms8p1StX7WXXWVa4TGKb5q58TPA' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1tqIW5Ms8p1StX7WXXWVa4TGKb5q58TPA" -O covariance_joint.zip && rm -rf /tmp/cookies.txt
tar -zxvf covariance_tissue.tar.gz
unzip covariance_joint.zip