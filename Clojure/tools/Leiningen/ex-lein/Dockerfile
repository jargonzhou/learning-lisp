# FROM clojure:lein
# COPY . /usr/src/app
# WORKDIR /usr/src/app
# CMD ["lein", "run"]

FROM clojure:lein
COPY target/uberjar/ex-lein-0.1.0-SNAPSHOT-standalone.jar /usr/src/app/app-standalone.jar
WORKDIR /usr/src/app
CMD ["java", "-jar", "app-standalone.jar"]