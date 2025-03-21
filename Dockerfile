# Sử dụng image ASP.NET Core runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Build project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy file .csproj trước để tận dụng cache
COPY KTM_ASP.csproj ./
RUN dotnet restore "KTM_ASP.csproj"

# Copy toàn bộ mã nguồn
COPY . .

# Build và publish ứng dụng
RUN dotnet publish "KTM_ASP.csproj" -c Release -o /app/publish

# Tạo container cuối cùng từ base
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "KTM_ASP.dll"]
