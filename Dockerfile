# Base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Sao chép file .csproj vào container để tận dụng cache
COPY KTM_ASP/KTM_ASP.csproj KTM_ASP/

# Di chuyển vào thư mục dự án
WORKDIR /src/KTM_ASP

# Khôi phục các package
RUN dotnet restore "KTM_ASP.csproj"

# Sao chép toàn bộ mã nguồn vào container
COPY KTM_ASP/ .

# **Sửa lỗi build**
RUN dotnet build "KTM_ASP.csproj" -c Release -o /app/build --no-cache

# Publish ứng dụng
FROM build AS publish
RUN dotnet publish "KTM_ASP.csproj" -c Release -o /app/publish --no-cache

# Final stage
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Chạy ứng dụng
ENTRYPOINT ["dotnet", "KTM_ASP.dll"]
