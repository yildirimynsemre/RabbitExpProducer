FROM microsoft/dotnet:2.1-sdk AS build
COPY . RabbitExp003Producer/
WORKDIR /RabbitExp003Producer
run dotnet restore RabbitExp003Producer.sln

FROM build AS publish
WORKDIR /RabbitExp003Producer/
RUN dotnet publish RabbitExp003Producer.sln -c Release -o /app

FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
COPY . RabbitExp003Producer/
WORKDIR /app
EXPOSE 8003

FROM runtime AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "RabbitExp003Producer.dll"] 