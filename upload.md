# Subida de artefactos


## Google Cloud

Login:

```
gcloud auth login
```

Revisión de configuración (project, account, etc):

```
gcloud config list
```

Listado de proyectos disponibles:

```
gcloud projects list
```

Selección del proyecto activo:

```
gcloud config set project psyder-platform
```

Listar repositorios

```
gcloud artifacts repositories list
```

Selección de repositorio de artefactos activo:

```
gcloud config set artifacts/repository psyder-maven
```

Mostrar configuración de repo Maven:

```
gcloud artifacts print-settings mvn --repository=mi-repo-maven --location=europe-west1
gcloud artifacts print-settings mvn --repository=psyder-maven --location=europe-southwest1

```

Crear repo Maven

```
gcloud artifacts repositories create mi-repo-maven \
--repository-format=maven \
--location=europe-west1 \
--description="Repositorio Maven privado"
```

Subida de artefacto a repo Maven:

```
mvn deploy -DaltDeploymentRepository=releases::default::artifactregistry://europe-west1-maven.pkg.dev/hello-agent-457223/mi-repo-maven

mvn deploy -DaltDeploymentRepository=releases::default::artifactregistry://europe-southwest1-maven.pkg.dev/psyder-platform/psyder-maven
```

./git-command.sh mvn deploy -DaltDeploymentRepository=releases::default::artifactregistry://europe-southwest1-maven.pkg.dev/psyder-platform/psyder-maven

Importante, es necesaria la extensión:

```xml
    <build>
        <extensions>
            <extension>
                <groupId>com.google.cloud.artifactregistry</groupId>
                <artifactId>artifactregistry-maven-wagon</artifactId>
                <version>2.2.0</version>
            </extension>
        </extensions>
    ...
    <build>
```
