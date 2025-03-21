using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using KTM_ASP.Data;
using KTM_ASP.Models;
using System;
using System.Linq;
namespace KTM_ASP.Models
{
        public static class SeedData
        {
            public static void Initialize(IServiceProvider serviceProvider)
            {

                using (var context = new KTM_ASPContext(
                    serviceProvider.GetRequiredService<
                        DbContextOptions<KTM_ASPContext>>()))
                {
                
                    if (context.Interiors.Any())
                    {
                        return;  
                    }

                    context.Interiors.AddRange(
                        new Interiors
                        {
                            TenSanPham = "Ghế",
                            MieuTa = "Ghế Tròn Đan Dây AM - 007A",
                            SoLuong = 15,
                            Gia = 15000000,
                            ChatLieu = "Vải",
                            MauSac = "Nâu",
                            HinhAnh = "/img/p11.png"
                        },
                        new Interiors
                        {
                            TenSanPham = "Tủ Tivi",
                            MieuTa = "Tủ Tivi Cao Cấp 38T",
                            SoLuong = 10,
                            Gia = 11111111,
                            ChatLieu = "Gỗ",
                            MauSac = "Nâu",
                            HinhAnh = "/img/p10.png"
                        }
                    );

                    context.SaveChanges();
                }
            }
        }
    }
