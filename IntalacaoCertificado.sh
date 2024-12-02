
#!/bin/bash
# IntalacaoCertificado.sh - Script para auxilio na instalação de certificados
# Script criado para auxiliar na instalação dos certificados digitais para sites que estão atrás de um haproxy
# Autor  : Tamiris Coutinho


#Declaração da variaveis a ser utilizadas
DIR="/home/diretorio-armazenado-os-certificados/"
filepem="*.pem"
filecer="*.cer"
filecsr="*.csr"
filekey="*.key"
chavekey=""

#recebendo o nome do site a ser criado o certificado
read -p "Digite o nome do site:" chavekey


#linha que renomeia o .pem para .crt
for arquivopem in ${DIR}/*${filepem}; do
   if [ -e "$arquivopem" ]; then
      filecrt="${arquivopem%$filepem}$filecrt.crt"
      mv "$arquivopem" "$filecrt"
      echo "Arquivo renomeado $filecrt "
   else
      echo "arquivo não encontrado"
   fi
done


#verificando se os aquivos cer, csr e key existe

for arquivocer in ${DIR}/*${filecer}; do
   if [ -e "$arquivocer" ]; then
      echo "arquivo  existe $arquivocer"
   else
      echo "não encontrado"
   fi
done




for arquivocsr in ${DIR}/*${filecsr}; do
   if [ -e "$arquivocsr" ]; then
      echo "arquivo existe $arquivocer "
   else
      echo "não existe"
   fi
done



for arquivokey in ${DIR}/*${filekey}; do
   if [ -e "$arquivokey" ]; then
      echo "arquivo existe $arquivokey "
   else
      echo "não existe"
   fi
done


#concatenando os arquivos e gerando um novo .pem
cat "$arquivocer" "$arquivocsr" "$arquivokey" > "${chavekey}.pem"


#copiando para pasta do haproxy
cp  "${DIR}/$chavekey".pem  /etc/haproxy/certs/

#restart do servidor
/etc/init.d/haproxy stop && /etc/init.d/haproxy start

#apaga os arquivos do diretorio atual
echo "Removendo os arquivos do diretório atual..."
rm -rf ca_chain.crt
rm -rf *.cer
rm -rf *.csr
rm -rf *.key
rm -rf *.pem
