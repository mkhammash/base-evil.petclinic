FROM adoptopenjdk:11.0.3_7-jdk-openj9-0.14.0

#Secret exposed
COPY id_rsa ~/.ssh/id_rsa

#Virus included
COPY eicar ~/eicar.txt
CMD sed 's/999STANDARD/STANDARD' eicar.txt

USER root

#Install vulnerable os level packages
CMD apt-get install nmap nc

#Expose vulnerable ports
EXPOSE 22
EXPOSE 80

ARG DEPENDENCY=target/dependency

COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","org.springframework.samples.petclinic.PetClinicApplication"]