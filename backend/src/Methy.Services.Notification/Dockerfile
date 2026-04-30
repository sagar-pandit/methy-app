# Build stage — uses full .NET SDK
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy solution and props files first (layer caching)
COPY Directory.Build.props Directory.Packages.props ./
COPY src/Methy.Services.Notification/Methy.Services.Notification.csproj src/Methy.Services.Notification/
COPY src/Methy.Shared/Methy.Shared.csproj src/Methy.Shared/

RUN dotnet restore src/Methy.Services.Notification/Methy.Services.Notification.csproj

COPY src/Methy.Services.Notification/ src/Methy.Services.Notification/
COPY src/Methy.Shared/ src/Methy.Shared/

RUN dotnet publish src/Methy.Services.Notification/Methy.Services.Notification.csproj -c Release -o /app/publish --no-restore

# Runtime stage — minimal ASP.NET Core image
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Methy.Services.Notification.dll"]
