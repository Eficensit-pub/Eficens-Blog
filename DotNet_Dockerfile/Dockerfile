FROM dotnet/sdk:6.0 AS build 
# CI/CD Pipeline Configuration 

ARG NUGET_URL=Nugget_package_url 

ARG NUGET_USERNAME 

ARG NUGET_PASSWORD 

WORKDIR /app 
# Copy csproj and restore as distinct layers 
COPY . ./ 
RUN dotnet nuget add source ${NUGET_URL} \ 
    -n artifactory \ 
    -u ${NUGET_USERNAME} \ 
    -p ${NUGET_PASSWORD} \ 
    --store-password-in-clear-text 

RUN dotnet restore --source ${NUGET_URL} 
# Copy everything else and build 

COPY . ./ 

# Run Unit Tests 

# RUN dotnet test Service.Tests -c Release 

# Publish  

RUN dotnet publish \ 
    -o out \ 
    -c Release \ 
    --self-contained \ 
    -r linux-x64 \ 
    Service.csproj 

# Cleanup 
RUN dotnet nuget remove source artifactory 

# Build runtime image 

FROM dotnet/aspnet:6.0.16-2.30.0 
WORKDIR /app 

COPY --from=build /app/out . 

ENV ASPNETCORE_URLS=http://*:8080 

COPY rds-combined-ca-bundle.pem /etc/ssl/certs/ 

RUN chmod 644 /etc/ssl/certs/ && update-ca-certificates 

ENTRYPOINT ["dotnet", "demo.dll"] 